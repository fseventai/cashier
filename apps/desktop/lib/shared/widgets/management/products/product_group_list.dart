import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:cashier/core/models/product.dart';
import 'package:cashier/core/providers/product_group_provider.dart';
import 'package:cashier/core/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductGroupList extends ConsumerStatefulWidget {
  const ProductGroupList({super.key});

  @override
  ConsumerState<ProductGroupList> createState() => _ProductGroupListState();
}

class _ProductGroupListState extends ConsumerState<ProductGroupList> {
  final TextEditingController _filterController = TextEditingController();
  final Set<String> _expandedIds = {};
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _filterController.addListener(() {
      setState(() {
        _searchQuery = _filterController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  void _toggleExpanded(String id) {
    setState(() {
      if (_expandedIds.contains(id)) {
        _expandedIds.remove(id);
      } else {
        _expandedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(productGroupListProvider);
    final selectedId = ref.watch(selectedProductGroupIdProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: isDark ? AppColors.slate950 : Colors.white,
        border: Border(
          right: BorderSide(
            color: isDark ? AppColors.slate800 : AppColors.slate200,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isDark ? AppColors.slate900 : AppColors.slate50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  HugeIcon(
                    icon: HugeIcons.strokeRoundedFilter,
                    size: 16,
                    color: AppColors.slate400,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _filterController,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? Colors.white : AppColors.slate900,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Filter structure...',
                        hintStyle: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.slate400,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Divider(height: 1),

          // Tree View
          Expanded(
            child: groupsAsync.when(
              data: (groups) {
                // Build tree structure
                final rootGroups = groups
                    .where((g) => g.parentId == null)
                    .toList();

                if (_searchQuery.isNotEmpty) {
                  // If searching, show a flattened list of matches or filtered tree
                  final filteredGroups = groups
                      .where((g) => g.name.toLowerCase().contains(_searchQuery))
                      .toList();
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filteredGroups.length,
                    itemBuilder: (context, index) {
                      return _TreeItem(
                        group: filteredGroups[index],
                        level: 0,
                        isSelected: selectedId == filteredGroups[index].id,
                        isExpanded: false,
                        onTap: () =>
                            ref
                                .read(selectedProductGroupIdProvider.notifier)
                                .state = filteredGroups[index]
                                .id,
                        onToggle: () {},
                        hasChildren: false,
                      );
                    },
                  );
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  children: rootGroups
                      .map(
                        (g) => _buildRecursiveTree(
                          g,
                          groups,
                          0,
                          selectedId,
                          isDark,
                        ),
                      )
                      .toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Text(
                  'Error: $err',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

          // Summary Footer
          groupsAsync.when(
            data: (groups) {
              final rootCount = groups.where((g) => g.parentId == null).length;
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: isDark ? AppColors.slate800 : AppColors.slate100,
                    ),
                  ),
                ),
                child: Text(
                  '${groups.length} Active Groups • $rootCount Root Level Categories',
                  style: AppTextStyles.bodySmall.copyWith(
                    fontSize: 11,
                    color: AppColors.slate400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (err, _) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildRecursiveTree(
    ProductGroup group,
    List<ProductGroup> allGroups,
    int level,
    String? selectedId,
    bool isDark,
  ) {
    final children = allGroups.where((g) => g.parentId == group.id).toList();
    final isExpanded = _expandedIds.contains(group.id);
    final hasChildren = children.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TreeItem(
          group: group,
          level: level,
          isSelected: selectedId == group.id,
          isExpanded: isExpanded,
          hasChildren: hasChildren,
          onTap: () => ref.read(selectedProductGroupIdProvider.notifier).state =
              group.id,
          onToggle: () => _toggleExpanded(group.id),
        ),
        if (isExpanded && hasChildren)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isDark ? AppColors.slate800 : AppColors.slate200,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: children
                    .map(
                      (child) => _buildRecursiveTree(
                        child,
                        allGroups,
                        level + 1,
                        selectedId,
                        isDark,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
      ],
    );
  }
}

class _TreeItem extends ConsumerWidget {
  final ProductGroup group;
  final int level;
  final bool isSelected;
  final bool isExpanded;
  final bool hasChildren;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  const _TreeItem({
    required this.group,
    required this.level,
    required this.isSelected,
    required this.isExpanded,
    required this.hasChildren,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final products = ref.watch(productListProvider).value ?? [];
    final count = products.where((p) => p.groupId == group.id).length;

    // Simulate children hierarchy counts for aesthetics if count is 0
    final displayCount = count > 0 ? count : (hasChildren ? 0 : 0);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      hoverColor: isDark ? AppColors.slate800 : AppColors.slate50,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark
                    ? AppColors.emerald900.withValues(alpha: 0.3)
                    : AppColors.emerald50)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(0),
          border: isSelected
              ? Border(left: BorderSide(color: AppColors.emerald500, width: 4))
              : null,
        ),
        child: Row(
          children: [
            // Expansion arrow
            if (hasChildren)
              GestureDetector(
                onTap: () {
                  onToggle();
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: HugeIcon(
                    icon: isExpanded
                        ? HugeIcons.strokeRoundedArrowDown01
                        : HugeIcons.strokeRoundedArrowRight01,
                    size: 16,
                    color: isSelected
                        ? AppColors.emerald500
                        : AppColors.slate400,
                  ),
                ),
              )
            else if (level > 0)
              const SizedBox(width: 20)
            else
              const SizedBox(width: 20),

            const SizedBox(width: 4),

            HugeIcon(
              icon: level == 0
                  ? (isExpanded
                        ? HugeIcons.strokeRoundedFolderOpen
                        : HugeIcons.strokeRoundedFolder01)
                  : (level == 1
                        ? HugeIcons.strokeRoundedPackage
                        : HugeIcons.strokeRoundedArrowRight01),
              size: 18,
              color: isSelected ? AppColors.emerald500 : AppColors.slate500,
            ),

            const SizedBox(width: 10),

            // Name
            Expanded(
              child: Text(
                group.name,
                style: AppTextStyles.bodySmall.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected
                      ? (isDark ? Colors.white : AppColors.slate900)
                      : (isDark ? AppColors.slate300 : AppColors.slate700),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Count Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.emerald500
                    : (isDark ? AppColors.slate800 : AppColors.slate100),
                borderRadius: BorderRadius.circular(10),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.emerald500.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                '$displayCount',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : AppColors.slate400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
