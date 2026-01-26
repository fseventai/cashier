import 'package:cashier/core/constants/apps/app_colors.dart';
import 'package:cashier/core/constants/apps/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const env = String.fromEnvironment('ENV', defaultValue: 'development');
  await dotenv.load(
    fileName: env == 'production' ? ".env.production" : ".env.development",
  );

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1280, 720),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setMinimumSize(const Size(1024, 768));
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });

  await initializeDateFormatting('id_ID', null);
  runApp(const ProviderScope(child: CoopPosApp()));
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
      routes: AppRoutes.routeMap,
    );
  }
}
