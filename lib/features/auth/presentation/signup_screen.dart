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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordMode = true;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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

  Future<void> _createAccount() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    await DummyAuthService.instance.createAccount(
      name: _nameController.text,
      email: _emailController.text,
    );
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushNamed(
      context,
      AppRoutes.verifyEmail,
      arguments: VerifyEmailArguments(
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
      ),
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
                  title: 'Create your account',
                  description:
                      'Start scanning products and get health flags that matter to you.',
                  illustrationAsset: AppAssets.signupIllustration,
                  illustrationSemanticsLabel: 'ScanWell account setup preview',
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
                              AppTextField(
                                label: 'Name',
                                hint: 'Enter your full name',
                                controller: _nameController,
                                prefixIcon: AppIcons.person_outline,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if ((value ?? '').trim().isEmpty) {
                                    return 'Enter your full name';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: AppSpacing.v18),
                              AppTextField(
                                label: 'Email address',
                                hint: 'Enter your email address',
                                controller: _emailController,
                                requiredField: true,
                                prefixIcon: AppIcons.mail_outline,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: _validateEmail,
                              ),
                              const SizedBox(height: AppSpacing.v18),
                              AppTextField(
                                label: 'Phone number (optional)',
                                hint: 'Enter your phone number',
                                controller: _phoneController,
                                prefixIcon: AppIcons.phone_outlined,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: AppSpacing.v18),
                              AppTextField(
                                label: 'Password',
                                hint: 'Create a strong password',
                                controller: _passwordController,
                                prefixIcon: AppIcons.lock_outline,
                                obscureText: _obscurePassword,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (!_passwordMode) return null;
                                  if ((value ?? '').isEmpty) {
                                    return 'Create a password';
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
                              const SizedBox(height: AppSpacing.v18),
                              const Text(
                                'Choose how you want to log in',
                                style: AppTextStyles.preDashboardSectionTitle,
                              ),
                              const SizedBox(height: AppSizes.v10),
                              SegmentedAuthSelector(
                                leftLabel: 'Password',
                                rightLabel: 'OTP login option',
                                leftIcon: AppIcons.lock,
                                rightIcon: AppIcons.phone_outlined,
                                leftSelected: _passwordMode,
                                onChanged: (value) {
                                  setState(() => _passwordMode = value);
                                },
                              ),
                              const SizedBox(height: AppSpacing.v18),
                              const SecurityNote(
                                text:
                                    'We use your email to secure your account and save your scan history.',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.v20),
                        AppButton(
                          label: 'Create Account',
                          isLoading: _isLoading,
                          onPressed: _createAccount,
                          size: AppButtonSize.preDashboard,
                          emphasis: AppButtonEmphasis.standard,
                        ),
                        const SizedBox(height: AppSizes.v14),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: AppTextStyles.authInlineText,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.login,
                              ),
                              child: const Text(
                                'Log in',
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
