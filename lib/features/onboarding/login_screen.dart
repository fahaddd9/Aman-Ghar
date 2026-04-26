import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/app_constants.dart';

// ─────────────────────────────────────────────────────────────────────────────
// LoginScreen — Tab bar with Login and Sign Up forms
// Receives 'role' as extra param. Dummy validation → navigates to /home
// ─────────────────────────────────────────────────────────────────────────────
class LoginScreen extends ConsumerStatefulWidget {
  final String role;
  const LoginScreen({super.key, required this.role});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool get _isHirer => widget.role == 'hirer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xl),

              // ── Back button ──────────────────────────────────────────
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/role-select');
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Title ────────────────────────────────────────────────
              Text(AppConstants.loginTitle, style: AppTextStyles.headingLarge),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _isHirer
                    ? AppConstants.hirerLoginSubtitle
                    : AppConstants.providerLoginSubtitle,
                style: AppTextStyles.bodyMedium,
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Tab bar ──────────────────────────────────────────────
              TabBar(
                controller: _tabController,
                labelStyle: AppTextStyles.headingSmall,
                unselectedLabelStyle: AppTextStyles.bodyLarge,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppColors.primary, width: 3),
                ),
                tabs: const [
                  Tab(text: 'Login'),
                  Tab(text: 'Sign Up'),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Tab content ──────────────────────────────────────────
              // Adjusted height to be more responsive and avoid overflows
              SizedBox(
                height: 480, 
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _LoginForm(onSuccess: () => context.go('/home')),
                    _SignUpForm(onSuccess: () => context.go('/home')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _LoginForm
// ─────────────────────────────────────────────────────────────────────────────
class _LoginForm extends StatefulWidget {
  final VoidCallback onSuccess;
  const _LoginForm({required this.onSuccess});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(
              hint: 'Email address',
              icon: Icons.email_rounded,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            obscureText: _obscurePassword,
            decoration: _inputDecoration(
              hint: 'Password',
              icon: Icons.lock_rounded,
              suffix: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: AppColors.textHint,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style:
                    AppTextStyles.bodyMedium.copyWith(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _LoginButton(label: 'LOGIN', onTap: widget.onSuccess),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SignUpForm
// ─────────────────────────────────────────────────────────────────────────────
class _SignUpForm extends StatefulWidget {
  final VoidCallback onSuccess;
  const _SignUpForm({required this.onSuccess});

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration:
                _inputDecoration(hint: 'Full name', icon: Icons.person_rounded),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration(
                hint: 'Email address', icon: Icons.email_rounded),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: _inputDecoration(
                hint: 'Phone number', icon: Icons.phone_rounded),
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            obscureText: _obscurePassword,
            decoration: _inputDecoration(
              hint: 'Create password',
              icon: Icons.lock_rounded,
              suffix: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: AppColors.textHint,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          _LoginButton(label: 'CREATE ACCOUNT', onTap: widget.onSuccess),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LoginButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppRadius.button),
          boxShadow: AppShadows.button,
        ),
        child: Center(
          child: Text(
            label,
            style:
                AppTextStyles.headingSmall.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

InputDecoration _inputDecoration({
  required String hint,
  required IconData icon,
  Widget? suffix,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
    prefixIcon: Icon(icon, color: AppColors.textHint, size: 20),
    suffixIcon: suffix,
    filled: true,
    fillColor: AppColors.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: const BorderSide(color: AppColors.divider),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.input),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}
