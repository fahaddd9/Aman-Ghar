// Purpose: AmanGhar entry point — initializes ScreenUtil and wraps app in ProviderScope.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 1 (flutter_screenutil init)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/config/app_router.dart';
import 'core/config/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ─────────────────────────────────────────────────────────────────────────────
// main — AmanGhar entry point
// Wraps the entire app in ProviderScope for Riverpod state management
// ─────────────────────────────────────────────────────────────────────────────
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
// AmanGharApp — Root widget with ScreenUtilInit
// designSize: iPhone 14 (390×844) as baseline
// ─────────────────────────────────────────────────────────────────────────────
class AmanGharApp extends ConsumerWidget {
  const AmanGharApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          title: 'AmanGhar',
          debugShowCheckedModeBanner: false,

          // ── AmanGhar custom Material 3 theme ──────────────────────────
          theme: AppTheme.lightTheme,

          // ── go_router navigation ──────────────────────────────────────
          routerConfig: router,
        );
      },
    );
  }
}
