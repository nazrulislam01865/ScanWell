import 'package:flutter/material.dart';

import 'package:food_nutrient_app/core/design_system/design_system.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/layout/responsive_layout.dart';
import '../../../core/widgets/app_button.dart';
import '../data/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleGetStarted() {
    if (_currentIndex < onboardingPages.length - 1) {
      _controller.nextPage(
        duration: AppMotion.ms320,
        curve: Curves.easeOutCubic,
      );
      return;
    }

    Navigator.pushNamed(context, AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemCount: onboardingPages.length,
          onPageChanged: (index) => setState(() => _currentIndex = index),
          itemBuilder: (context, index) {
            return _OnboardingPage(
              page: onboardingPages[index],
              index: index,
              onGetStarted: _handleGetStarted,
              onLogin: () => Navigator.pushNamed(context, AppRoutes.login),
            );
          },
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.page,
    required this.index,
    required this.onGetStarted,
    required this.onLogin,
  });

  final OnboardingPageData page;
  final int index;
  final VoidCallback onGetStarted;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);
    final tablet = ResponsiveLayout.isTablet(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: AppSizes.contentMedium,
              ),
              child: Padding(
                padding: ResponsiveLayout.pagePadding(
                  context,
                  compactHorizontal: AppSpacing.v18,
                  phoneHorizontal: AppSpacing.xxxl,
                  tabletHorizontal: AppSpacing.v36,
                  top: compact ? 18 : 24,
                  bottom: AppSpacing.v22,
                ),
                child: Column(
                  children: [
                    _PageIndicator(activeIndex: index),
                    SizedBox(height: compact ? AppSizes.v9 : AppSizes.v12),
                    Text(
                      '${index + 1} of ${onboardingPages.length}',
                      style: AppTextStyles.onboardingStepFor(compact: compact),
                    ),
                    SizedBox(height: compact ? AppSizes.v8 : AppSizes.v10),
                    Semantics(
                      image: true,
                      label: page.title,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: tablet ? AppSizes.v520 : AppSizes.v560,
                        ),
                        child: Image.asset(
                          page.imageAsset,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: compact ? AppSizes.v12 : AppSizes.v14),
                    Text(
                      page.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.onboardingTitleFor(compact: compact),
                    ),
                    SizedBox(height: compact ? AppSizes.v7 : AppSizes.v9),
                    Text(
                      page.description,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.onboardingBodyFor(compact: compact),
                    ),
                    SizedBox(height: compact ? AppSizes.v22 : AppSizes.v28),
                    AppButton(
                      label: 'Get Started',
                      onPressed: onGetStarted,
                      size: AppButtonSize.preDashboard,
                      emphasis: AppButtonEmphasis.standard,
                    ),
                    const SizedBox(height: AppSizes.v10),
                    TextButton(
                      onPressed: onLogin,
                      child: Text(
                        'Login',
                        style: AppTextStyles.authLink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.activeIndex});

  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    final compact = ResponsiveLayout.isCompact(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingPages.length,
        (index) => AnimatedContainer(
          duration: AppMotion.ms220,
          width: compact ? AppSizes.v10 : AppSizes.v12,
          height: compact ? AppSizes.v10 : AppSizes.v12,
          margin: EdgeInsets.symmetric(horizontal: compact ? AppSpacing.v6 : AppSpacing.v8),
          decoration: BoxDecoration(
            color: index == activeIndex
                ? AppColors.primary
                : AppColors.toneFFDADCDD,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
