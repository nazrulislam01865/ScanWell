import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/auth_card.dart';
import '../../../core/widgets/auth_hero_header.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/security_note.dart';
import '../../../core/widgets/segmented_auth_selector.dart';
import '../data/dummy_auth_service.dart';
import 'verify_email_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordMode = true;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Enter your email address';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    final email = _emailController.text.trim();

    if (_passwordMode) {
      final success = await DummyAuthService.instance.login(
        email: email,
        password: _passwordController.text,
      );
      if (!mounted) return;
      setState(() => _isLoading = false);

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Use a password with at least 6 characters.'),
          ),
        );
        return;
      }

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
      return;
    }

    await DummyAuthService.instance.requestLoginOtp(email);
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushNamed(
      context,
      AppRoutes.verifyEmail,
      arguments: VerifyEmailArguments(email: email, isLogin: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ResponsiveContent(
            child: Column(
              children: [
                const AuthHeroHeader(
                  title: 'Welcome back',
                  description:
                      'Log in to view scan history, saved products, and personalized health flags.',
                  illustrationAsset: AppAssets.loginIllustration,
                  illustrationSemanticsLabel: 'ScanWell product scanning preview',
                  illustrationKey: ValueKey('login-illustration'),
                ),
                Padding(
                  padding: ResponsiveLayout.pagePadding(
                    context,
                    compactHorizontal: AppSpacing.lg,
                    phoneHorizontal: AppSpacing.v22,
                    tabletHorizontal: AppSpacing.v26,
                    bottom: AppSpacing.v28,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SegmentedAuthSelector(
                                leftLabel: 'Password',
                                rightLabel: 'OTP',
                                leftIcon: AppIcons.lock,
                                rightIcon: AppIcons.phone_outlined,
                                leftSelected: _passwordMode,
                                onChanged: (value) {
                                  setState(() => _passwordMode = value);
                                },
                              ),
                              SizedBox(
                                height: ResponsiveLayout.isCompact(context)
                                    ? AppSpacing.v18
                                    : AppSpacing.v22,
                              ),
                              AppTextField(
                                label: 'Email address',
                                hint: 'Enter your email address',
                                controller: _emailController,
                                requiredField: true,
                                prefixIcon: AppIcons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: _passwordMode
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                validator: _validateEmail,
                              ),
                              if (_passwordMode) ...[
                                const SizedBox(height: AppSpacing.v18),
                                AppTextField(
                                  label: 'Password',
                                  hint: 'Enter your password',
                                  controller: _passwordController,
                                  requiredField: true,
                                  prefixIcon: AppIcons.lock_outline,
                                  obscureText: _obscurePassword,
                                  textInputAction: TextInputAction.done,
                                  validator: (value) {
                                    if ((value ?? '').isEmpty) {
                                      return 'Enter your password';
                                    }
                                    if ((value ?? '').length < 6) {
                                      return 'Use at least 6 characters';
                                    }
                                    return null;
                                  },
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(
                                      () => _obscurePassword =
                                          !_obscurePassword,
                                    ),
                                    icon: Icon(
                                      _obscurePassword
                                          ? AppIcons.visibility_outlined
                                          : AppIcons.visibility_off_outlined,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: AppSpacing.controlGap),
                                    child: TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Password recovery is ready for backend integration.',
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Forgot password?',
                                        style: AppTextStyles.authLink,
                                      ),
                                    ),
                                  ),
                                ),
                              ] else
                                const SizedBox(height: AppSizes.v24),
                              const SecurityNote(
                                text:
                                    'We use your email to secure your account and save your scan history.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.v18),
                        AppButton(
                          label: _passwordMode ? 'Log In' : 'Send OTP',
                          isLoading: _isLoading,
                          onPressed: _submit,
                          size: AppButtonSize.preDashboard,
                          emphasis: AppButtonEmphasis.standard,
                        ),
                        const SizedBox(height: AppSizes.v10),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () => setState(
                                    () => _passwordMode = !_passwordMode,
                                  ),
                          child: Text(
                            _passwordMode
                                ? 'Use OTP instead'
                                : 'Use password instead',
                            style: AppTextStyles.authLink,
                          ),
                        ),
                        const SizedBox(height: AppSizes.v12),
                        const _OrDivider(),
                        const SizedBox(height: AppSizes.v11),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              'Don’t have an account? ',
                              style: AppTextStyles.authInlineText,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.signup,
                              ),
                              child: const Text(
                                'Sign up',
                                style: AppTextStyles.authLink,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            'or',
            style: AppTextStyles.preDashboardSupporting,
          ),
        ),
        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
