import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postj/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:postj/l10n/app_localizations.dart';
import 'package:postj/src/theme/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingSlides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<OnboardingCubit>().complete();
    }
  }

  void _skip() {
    context.read<OnboardingCubit>().complete();
  }

  List<_OnboardingSlide> get _onboardingSlides {
    final l10n = AppLocalizations.of(context)!;
    return [
      _OnboardingSlide(
        icon: Icons.sports_soccer,
        title: l10n.onboardingWelcome,
        subtitle: l10n.onboardingWelcomeSubtitle,
        color: kGreen,
      ),
      _OnboardingSlide(
        icon: Icons.calendar_today,
        title: l10n.onboardingCalendar,
        subtitle: l10n.onboardingCalendarSubtitle,
        color: kBlue,
      ),
      _OnboardingSlide(
        icon: Icons.emoji_events,
        title: l10n.onboardingResults,
        subtitle: l10n.onboardingResultsSubtitle,
        color: kOrange,
      ),
      _OnboardingSlide(
        icon: Icons.star,
        title: l10n.onboardingScorers,
        subtitle: l10n.onboardingScorersSubtitle,
        color: kYellow,
      ),
      _OnboardingSlide(
        icon: Icons.videocam,
        title: l10n.onboardingLive,
        subtitle: l10n.onboardingLiveSubtitle,
        color: kRed,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final slides = _onboardingSlides;

    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    l10n.skip,
                    style: const TextStyle(
                      color: kGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // PageView with slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return _OnboardingSlideWidget(slide: slides[index]);
                },
              ),
            ),

            // Page indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: slides.length,
                effect: const WormEffect(
                  spacing: 8.0,
                  radius: 6.0,
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  paintStyle: PaintingStyle.fill,
                  dotColor: Color(0xFFE0E0E0),
                  activeDotColor: kWebViewHeaderBlue,
                ),
              ),
            ),

            // Next/Get Started button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kWebViewHeaderBlue,
                    foregroundColor: kWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == slides.length - 1
                        ? l10n.getStarted
                        : l10n.next,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

class _OnboardingSlideWidget extends StatelessWidget {
  final _OnboardingSlide slide;

  const _OnboardingSlideWidget({required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with gradient background
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  slide.color,
                  slide.color.withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: slide.color.withOpacity(0.3),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(
              slide.icon,
              size: 100,
              color: kWhite,
            ),
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: kBlack,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),

          // Subtitle
          Text(
            slide.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: kGrey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
