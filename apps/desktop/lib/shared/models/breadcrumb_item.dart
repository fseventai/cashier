import 'dart:ui';

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.label, this.onTap});
}
