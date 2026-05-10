// Purpose: All go_router routes for AmanGhar with ShellRoute for bottom nav.
// Doc: 04_ui_improvement_and_fix_phase.md — Step 8: Bottom Navigation & Global Navigation Fix

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/role_selection_screen.dart';
import '../../features/onboarding/login_screen.dart';
import '../../features/onboarding/signup_screen.dart';
import '../../features/onboarding/forgot_password_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/search/search_results_screen.dart';
import '../../features/service_profile/service_profile_screen.dart';
import '../../features/booking/booking_schedule_screen.dart';
import '../../features/booking/booking_status_screen.dart';
import '../../features/payment/payment_method_screen.dart';
import '../../features/payment/payment_success_screen.dart';
import '../../features/chat/chat_screen.dart';
import '../../features/chat/inbox_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/profile/my_bookings_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/profile/payment_history_screen.dart';
import '../../features/profile/earnings_screen.dart';
import '../../features/payment/withdraw_screen.dart';
import '../../features/booking/incoming_request_detail_screen.dart';
import '../../features/profile/support_screen.dart';
import '../../features/profile/about_screen.dart';
import '../../features/profile/rate_now_screen.dart';
import '../../shared/widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppRoutes — All route path constants
// ─────────────────────────────────────────────────────────────────────────────
class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String roleSelect = '/role-select';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
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
  static const String editProfile = '/edit-profile';
  static const String paymentHistory = '/payment-history';
  static const String support = '/support';
  static const String about = '/about';
  static const String rateNow = '/rate-now/:id';
  static const String inbox = '/inbox';
  static const String earnings = '/earnings';
  static const String withdraw = '/withdraw';
  static const String requestDetail = '/request-detail/:id';
}

// ─────────────────────────────────────────────────────────────────────────────
// _buildPageTransition — Reusable FadeTransition + SlideTransition from right
// Applied to every route for consistency. 280ms, easeOutCubic.
// ─────────────────────────────────────────────────────────────────────────────
CustomTransitionPage<void> _buildPageTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    reverseTransitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      final Animation<Offset> slideTween = Tween<Offset>(
        begin: const Offset(0.06, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      ));
      final Animation<double> fadeTween =
          Tween<double>(begin: 0.0, end: 1.0).animate(
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
// routerProvider — GoRouter instance with Riverpod and Auth Redirect
// ─────────────────────────────────────────────────────────────────────────────
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      // We only want to handle auth redirects after the splash screen.
      // But for simplicity, we can do it globally.
      final isAuth = authState.valueOrNull != null;
      
      final isSplash = state.uri.toString() == AppRoutes.splash;
      final isLogin = state.uri.toString() == AppRoutes.login;
      final isSignup = state.uri.toString() == AppRoutes.signup;
      final isRoleSelect = state.uri.toString() == AppRoutes.roleSelect;
      final isForgotPassword = state.uri.toString() == AppRoutes.forgotPassword;
      
      final isAuthRoute = isLogin || isSignup || isRoleSelect || isForgotPassword;

      if (isSplash) return null; // Let splash screen handle its own delay

      // If not authenticated and trying to access a protected route
      if (!isAuth && !isAuthRoute) {
        return AppRoutes.roleSelect;
      }

      // If authenticated and trying to access auth routes
      if (isAuth && isAuthRoute) {
        return AppRoutes.home;
      }

      return null; // No redirect
    },
    routes: [
      // ── Splash ───────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.splash,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const SplashScreen(),
        ),
      ),

      // ── Role Selection ───────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.roleSelect,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const RoleSelectionScreen(),
        ),
      ),

      // ── Login ────────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.login,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String role = state.extra as String? ?? 'hirer';
          return _buildPageTransition(
            context: context,
            state: state,
            child: LoginScreen(role: role),
          );
        },
      ),

      // ── Sign Up ──────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.signup,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String role = state.extra as String? ?? 'hirer';
          return _buildPageTransition(
            context: context,
            state: state,
            child: SignupScreen(role: role),
          );
        },
      ),

      // ── Forgot Password ──────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.forgotPassword,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const ForgotPasswordScreen(),
        ),
      ),

      // ── Home ─────────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const HomeScreen(),
        ),
      ),

      // ── Search Results ───────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.search,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String query = state.uri.queryParameters['q'] ?? '';
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
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? '1';
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
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? '1';
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
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const PaymentMethodScreen(),
        ),
      ),

      // ── Payment Success ──────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.paymentSuccess,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const PaymentSuccessScreen(),
        ),
      ),

      // ── Booking Status ───────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.bookingStatus,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const BookingStatusScreen(),
        ),
      ),

      // ── Chat ─────────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.chat,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? '1';
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
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const ProfileScreen(),
        ),
      ),

      // ── My Bookings ──────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.myBookings,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const MyBookingsScreen(),
        ),
      ),

      // ── Edit Profile ─────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.editProfile,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const EditProfileScreen(),
        ),
      ),

      // ── Payment History ──────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.paymentHistory,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const PaymentHistoryScreen(),
        ),
      ),

      // ── Earnings ─────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.earnings,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const EarningsScreen(),
        ),
      ),

      // ── Support ──────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.support,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const SupportScreen(),
        ),
      ),

      // ── About ────────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.about,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const AboutScreen(),
        ),
      ),

      // ── Rate Now ─────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.rateNow,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? '1';
          return _buildPageTransition(
            context: context,
            state: state,
            child: RateNowScreen(providerId: id),
          );
        },
      ),
      // ── Inbox ────────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.inbox,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const InboxScreen(),
        ),
      ),

      // ── Incoming Request Detail ──────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.requestDetail,
        pageBuilder: (BuildContext context, GoRouterState state) {
          final String id = state.pathParameters['id'] ?? '1';
          return _buildPageTransition(
            context: context,
            state: state,
            child: IncomingRequestDetailScreen(requestId: id),
          );
        },
      ),

      // ── Withdraw ─────────────────────────────────────────────────────────────
      GoRoute(
        path: AppRoutes.withdraw,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            _buildPageTransition(
          context: context,
          state: state,
          child: const WithdrawScreen(),
        ),
      ),
    ],
  );
});
