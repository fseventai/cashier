import 'package:flutter/material.dart';
import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_text_styles.dart';
import 'package:hugeicons/hugeicons.dart';

class SalesHistoryFilterBar extends StatelessWidget {
  final TextEditingController? searchController;
  final String dateRangeText;
  final VoidCallback? onDateRangeTap;
  final ValueChanged<String>? onSearchChanged;
  final List<String> searchSuggestions;

  const SalesHistoryFilterBar({
    super.key,
    this.searchController,
    this.dateRangeText = '22/12/2025 - 22/12/2025',
    this.onDateRangeTap,
    this.onSearchChanged,
    this.searchSuggestions = const [],
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Search autocomplete
          _SearchAutocomplete(
            controller: searchController,
            suggestions: searchSuggestions,
            onChanged: onSearchChanged,
            isDark: isDark,
          ),
          const SizedBox(width: 12),

          // Date range picker
          _DateRangeButton(
            dateRangeText: dateRangeText,
            onTap: onDateRangeTap,
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _SearchAutocomplete extends StatefulWidget {
  final TextEditingController? controller;
  final List<String> suggestions;
  final ValueChanged<String>? onChanged;
  final bool isDark;

  const _SearchAutocomplete({
    this.controller,
    required this.suggestions,
    this.onChanged,
    required this.isDark,
  });

  @override
  State<_SearchAutocomplete> createState() => _SearchAutocompleteState();
}

class _SearchAutocompleteState extends State<_SearchAutocomplete> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _filteredSuggestions = [];
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    if (_filteredSuggestions.isEmpty) {
      _removeOverlay();
      return;
    }

    _removeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(6),
            color: widget.isDark ? AppColors.slate700 : Colors.white,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: _filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _filteredSuggestions[index];
                  return InkWell(
                    onTap: () {
                      _controller.text = suggestion;
                      widget.onChanged?.call(suggestion);
                      _removeOverlay();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      child: Text(
                        suggestion,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: widget.isDark
                              ? AppColors.slate200
                              : AppColors.textMain,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTextChanged(String value) {
    widget.onChanged?.call(value);
    setState(() {
      if (value.isEmpty) {
        _filteredSuggestions = [];
      } else {
        _filteredSuggestions = widget.suggestions
            .where((s) => s.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
    _showOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: SizedBox(
          width: 220,
          height: 36,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            onChanged: _onTextChanged,
            style: AppTextStyles.bodySmall.copyWith(
              color: widget.isDark ? Colors.white : AppColors.textMain,
            ),
            decoration: InputDecoration(
              hintText: 'Cari dokumen...',
              hintStyle: AppTextStyles.bodySmall.copyWith(
                color: widget.isDark ? AppColors.slate500 : AppColors.slate400,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10, right: 8),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedSearch01,
                  size: 18,
                  color: _isHovered || _focusNode.hasFocus
                      ? AppColors.emerald500
                      : (widget.isDark
                            ? AppColors.slate400
                            : AppColors.slate500),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 36,
                minHeight: 36,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.isDark
                      ? AppColors.slate600
                      : AppColors.slate300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: widget.isDark
                      ? AppColors.slate600
                      : AppColors.slate200,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: AppColors.emerald500,
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: widget.isDark
                  ? AppColors.slate800
                  : AppColors.surfaceAlt,
            ),
          ),
        ),
      ),
    );
  }
}

class _DateRangeButton extends StatefulWidget {
  final String dateRangeText;
  final VoidCallback? onTap;
  final bool isDark;

  const _DateRangeButton({
    required this.dateRangeText,
    this.onTap,
    required this.isDark,
  });

  @override
  State<_DateRangeButton> createState() => _DateRangeButtonState();
}

class _DateRangeButtonState extends State<_DateRangeButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.isDark ? AppColors.slate600 : AppColors.slate100)
                : (widget.isDark ? AppColors.slate800 : AppColors.surfaceAlt),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.isDark ? AppColors.slate700 : AppColors.slate200,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedCalendar03,
                size: 18,
                color: widget.isDark ? AppColors.slate400 : AppColors.slate500,
              ),
              const SizedBox(width: 8),
              Text(
                widget.dateRangeText,
                style: AppTextStyles.bodySmall.copyWith(
                  color: widget.isDark
                      ? AppColors.slate300
                      : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
