import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';
import 'package:flutter/services.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/auth_card.dart';
import '../../../core/widgets/auth_hero_header.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/security_note.dart';
import '../data/dummy_auth_service.dart';

class VerifyEmailArguments {
  const VerifyEmailArguments({
    required this.email,
    this.name,
    this.isLogin = false,
  });

  final String email;
  final String? name;
  final bool isLogin;
}

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({required this.arguments, super.key});

  final VerifyEmailArguments arguments;

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _handleCodeChanged(String value, int index) {
    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verify() async {
    final code = _controllers.map((controller) => controller.text).join();
    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the complete 6-digit code.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    final success = await DummyAuthService.instance.verify(code);
    if (!mounted) return;
    setState(() => _isLoading = false);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid code. Use 123456 for this demo.')),
      );
      return;
    }

    if (widget.arguments.isLogin) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.personalizedAlertSetup,
    );
  }

  void _resendCode() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'A new code was sent to ${widget.arguments.email}. Demo code: 123456',
        ),
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
                  title: 'Verify your email',
                  description:
                      'Enter the 6-digit code sent to your email address to secure your account.',
                  illustrationAsset: AppAssets.verifyIllustration,
                  illustrationSemanticsLabel: 'ScanWell email verification preview',
                ),
                Padding(
                  padding: ResponsiveLayout.pagePadding(
                    context,
                    compactHorizontal: AppSpacing.lg,
                    phoneHorizontal: AppSpacing.v22,
                    tabletHorizontal: AppSpacing.v26,
                    bottom: AppSpacing.v28,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.v15,
                          vertical: AppSpacing.lg,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.border),
                          borderRadius: BorderRadius.circular(AppRadii.v14),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: AppSizes.v34,
                              height: AppSizes.v34,
                              decoration: const BoxDecoration(
                                color: AppColors.softGreen,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                AppIcons.mail_outline,
                                color: AppColors.primary,
                                size: AppSizes.iconControlTight,
                              ),
                            ),
                            const SizedBox(width: AppSizes.v12),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Code sent to: ',
                                      style: AppTextStyle(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: widget.arguments.email,
                                      style: const AppTextStyle(
                                        color: AppColors.primary,
                                        fontWeight: AppTypography.weight600,
                                      ),
                                    ),
                                  ],
                                ),
                                style: AppTextStyles.authInlineText,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.v18),
                      AuthCard(
                        child: Column(
                          children: [
                            LayoutBuilder(
                              builder: (context, constraints) {
                                const count = 6;
                                final compact = constraints.maxWidth < 330;
                                final gap = compact ? 6.0 : 10.0;
                                final available =
                                    constraints.maxWidth - gap * (count - 1);
                                final boxWidth = (available / count)
                                    .clamp(30.0, 58.0)
                                    .toDouble();

                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    count,
                                    (index) => Padding(
                                      padding: EdgeInsets.only(
                                        right: index == count - AppSpacing.v1 ? AppSpacing.none : gap,
                                      ),
                                      child: _OtpBox(
                                        width: boxWidth,
                                        controller: _controllers[index],
                                        focusNode: _focusNodes[index],
                                        autofocus: index == 0,
                                        onChanged: (value) =>
                                            _handleCodeChanged(value, index),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: AppSpacing.v22),
                            const Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Icon(
                                  AppIcons.lock_outline,
                                  size: AppSizes.iconControlTight,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: AppSizes.v10),
                                Text(
                                  'Didn’t get the code?',
                                  style: AppTextStyles.preDashboardSupporting,
                                ),
                              ],
                            ),
                            TextButton.icon(
                              onPressed: _resendCode,
                              icon: const Icon(AppIcons.refresh, size: AppSizes.iconControl),
                              label: const Text(
                                'Resend code',
                                style: AppTextStyles.authLink,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.v16),
                            AppButton(
                              label: 'Verify Email',
                              isLoading: _isLoading,
                              onPressed: _verify,
                              size: AppButtonSize.preDashboard,
                              emphasis: AppButtonEmphasis.standard,
                            ),
                            const SizedBox(height: AppSpacing.v14),
                            const _OrDivider(),
                            const SizedBox(height: AppSizes.v10),
                            TextButton.icon(
                              onPressed: _isLoading
                                  ? null
                                  : () => Navigator.pushReplacementNamed(
                                        context,
                                        widget.arguments.isLogin
                                            ? AppRoutes.login
                                            : AppRoutes.signup,
                                      ),
                              icon: const Icon(AppIcons.edit_outlined, size: AppSizes.iconControl),
                              label: const Text(
                                'Change email',
                                style: AppTextStyles.authLink,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.v16),
                            const SecurityNote(
                              text:
                                  'You can continue after your email is verified.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.v18),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.width,
    required this.controller,
    required this.focusNode,
    required this.autofocus,
    required this.onChanged,
  });

  final double width;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool autofocus;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: width < AppSizes.v40 ? AppSizes.v50 : AppSizes.v56,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: onChanged,
        style: AppTextStyles.authOtpDigitFor(
          compact: width < AppSizes.v40,
        ),
        decoration: InputDecoration(
          hintText: '—',
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.card),
            borderSide: const BorderSide(color: AppColors.toneFFBFC4CA),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadii.card),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: AppSizes.v1_6,
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
