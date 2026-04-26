import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/role_selection_screen.dart';
import '../../features/onboarding/login_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/search/search_results_screen.dart';
import '../../features/service_profile/service_profile_screen.dart';
import '../../features/booking/booking_schedule_screen.dart';
import '../../features/booking/booking_status_screen.dart';
import '../../features/payment/payment_method_screen.dart';
import '../../features/payment/payment_success_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/my_bookings_screen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppRoutes — All route path constants
// ─────────────────────────────────────────────────────────────────────────────
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String roleSelect = '/role-select';
  static const String login = '/login';
  static const String home = '/home';
  static const String search = '/search';
  static const String provider = '/provider/:id';
  static const String booking = '/booking/:id';
  static const String payment = '/payment';
  static const String paymentSuccess = '/payment-success';
  static const String bookingStatus = '/booking-status';
  static const String chat = '/chat/:id';
  static const String profile = '/profile';
  static const String myBookings = '/my-bookings';
}

// ─────────────────────────────────────────────────────────────────────────────
// _buildPageTransition — Reusable FadeTransition + SlideTransition from right
// Applied to every route for consistency
// ─────────────────────────────────────────────────────────────────────────────
CustomTransitionPage<void> _buildPageTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final slideTween = Tween<Offset>(
        begin: const Offset(0.06, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ));
      final fadeTween = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
      );
      return FadeTransition(
        opacity: fadeTween,
        child: SlideTransition(position: slideTween, child: child),
      );
    },
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// AppRouter — GoRouter instance with all 13 routes
// ─────────────────────────────────────────────────────────────────────────────
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: false,
  routes: [
    // ── Splash ───────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),

    // ── Role Selection ───────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.roleSelect,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const RoleSelectionScreen(),
      ),
    ),

    // ── Login ────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) {
        final role = state.extra as String?;
        return _buildPageTransition(
          context: context,
          state: state,
          child: LoginScreen(role: role ?? 'hirer'),
        );
      },
    ),

    // ── Home ─────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const HomeScreen(),
      ),
    ),

    // ── Search Results ───────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.search,
      pageBuilder: (context, state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return _buildPageTransition(
          context: context,
          state: state,
          child: SearchResultsScreen(query: query),
        );
      },
    ),

    // ── Service Profile ──────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.provider,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '1';
        return _buildPageTransition(
          context: context,
          state: state,
          child: ServiceProfileScreen(providerId: id),
        );
      },
    ),

    // ── Booking Schedule ─────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.booking,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '1';
        return _buildPageTransition(
          context: context,
          state: state,
          child: BookingScheduleScreen(providerId: id),
        );
      },
    ),

    // ── Payment Method ───────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.payment,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const PaymentMethodScreen(),
      ),
    ),

    // ── Payment Success ──────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.paymentSuccess,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const PaymentSuccessScreen(),
      ),
    ),

    // ── Booking Status ───────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.bookingStatus,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const BookingStatusScreen(),
      ),
    ),

    // ── Chat ─────────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.chat,
      pageBuilder: (context, state) {
        final id = state.pathParameters['id'] ?? '1';
        return _buildPageTransition(
          context: context,
          state: state,
          child: ChatScreen(providerId: id),
        );
      },
    ),

    // ── Profile ──────────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const ProfileScreen(),
      ),
    ),

    // ── My Bookings ──────────────────────────────────────────────────────────
    GoRoute(
      path: AppRoutes.myBookings,
      pageBuilder: (context, state) => _buildPageTransition(
        context: context,
        state: state,
        child: const MyBookingsScreen(),
      ),
    ),
  ],
);
