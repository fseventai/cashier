import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_routes.dart';
import 'package:cashier/screens/pos_screen.dart';
import 'package:cashier/screens/management_screen.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });

  runApp(const CoopPosApp());
}

class CoopPosApp extends StatelessWidget {
  const CoopPosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coop POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.emerald500),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surfaceAlt,
      ),
      initialRoute: AppRoutes.pos,
      routes: {
        AppRoutes.pos: (context) => const PosScreen(),
        AppRoutes.management: (context) => const ManagementScreen(),
      },
    );
  }
}
