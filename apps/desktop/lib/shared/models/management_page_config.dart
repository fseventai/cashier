import 'package:flutter/material.dart';

class ManagementPageConfig {
  final Widget content;
  final Widget? drawer;
  final Widget? toolbar;

  ManagementPageConfig({required this.content, this.drawer, this.toolbar});
}
