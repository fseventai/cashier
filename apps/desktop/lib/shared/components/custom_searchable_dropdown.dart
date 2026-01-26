import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomSearchableDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T) itemAsString;
  final void Function(T?)? onChanged;
  final String? placeholder;
  final String? searchPlaceholder;
  final bool isRequired;
  final double maxHeight;

  const CustomSearchableDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.itemAsString,
    this.onChanged,
    this.placeholder,
    this.searchPlaceholder = 'Search...',
    this.isRequired = false,
    this.maxHeight = 300,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.slate300 : AppColors.slate700,
              ),
              children: [
                if (isRequired)
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
        DropdownSearch<T>(
          items: (filter, loadProps) => items
              .where(
                (item) => itemAsString(
                  item,
                ).toLowerCase().contains(filter.toLowerCase()),
              )
              .toList(),
          itemAsString: itemAsString,
          selectedItem: value,
          onChanged: onChanged,
          compareFn: (item, selectedItem) => item == selectedItem,
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: placeholder,
              hintStyle: AppTextStyles.bodySmall.copyWith(
                color: AppColors.slate400,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColors.slate200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: AppColors.slate200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: AppColors.emerald600,
                  width: 1.5,
                ),
              ),
              suffixIconColor: AppColors.slate400,
            ),
            baseStyle: AppTextStyles.bodySmall.copyWith(
              color: isDark ? Colors.white : AppColors.slate800,
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true,
            fit: FlexFit.loose,
            constraints: BoxConstraints(maxHeight: maxHeight),
            menuProps: MenuProps(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(6),
              elevation: 16,
              shadowColor: Colors.black.withValues(alpha: 0.2),
            ),
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  size: 20,
                  color: AppColors.slate400,
                ),
                hintText: searchPlaceholder,
                hintStyle: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.slate400,
                  fontSize: 12,
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColors.slate200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColors.slate200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(
                    color: AppColors.emerald600,
                    width: 1,
                  ),
                ),
                focusColor: AppColors.slate50,
                fillColor: AppColors.slate50,
                filled: true,
              ),
              style: AppTextStyles.bodySmall.copyWith(fontSize: 12),
            ),
            containerBuilder: (context, popupWidget) {
              return Container(
                padding: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.slate200, width: 1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: popupWidget,
              );
            },
            itemBuilder: (context, item, isSelected, isHover) {
              final label = itemAsString(item);
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.emerald600
                      : (isHover ? AppColors.slate50 : Colors.transparent),
                ),
                child: Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isSelected ? Colors.white : AppColors.slate700,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
