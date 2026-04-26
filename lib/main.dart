import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/app_router.dart';
import 'core/config/app_theme.dart';

// ─────────────────────────────────────────────────────────────────────────────
// main — AmanGhar entry point
// Wraps the entire app in ProviderScope for Riverpod state management
// ─────────────────────────────────────────────────────────────────────────────
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait orientation — AmanGhar is a mobile-first app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Status bar style — light icons on transparent bar for premium feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    const ProviderScope(
      child: AmanGharApp(),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// AmanGharApp — Root widget
// ─────────────────────────────────────────────────────────────────────────────
class AmanGharApp extends StatelessWidget {
  const AmanGharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AmanGhar',
      debugShowCheckedModeBanner: false,

      // ── AmanGhar custom Material 3 theme ──────────────────────────────
      theme: AppTheme.lightTheme,

      // ── go_router navigation ──────────────────────────────────────────
      routerConfig: appRouter,
    );
  }
}
