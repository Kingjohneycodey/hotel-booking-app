import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardPageData> _pages = const [
    _OnboardPageData(
      title: 'Luxury and Comfort, \nJust a Tap Away',
      description:
          'Find the perfect hotel for your next trip with our easy booking process.',
      backgroundImage: 'assets/images/onboarding1.png',
    ),
    _OnboardPageData(
      title: 'Book with Ease,\nStay with Style',
      description: 'Explore curated hotels and resorts tailored to your style.',
      backgroundImage: 'assets/images/onboarding1.png',
    ),
    _OnboardPageData(
      title: 'Discover Your Dream \nHotel, Effortlessly',
      description:
          'Secure payments and instant confirmations, anywhere you go.',
      backgroundImage: 'assets/images/onboarding1.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnboarding() async {
    // final preferences = await SharedPreferences.getInstance();
    // await preferences.setBool('hasOnboarded', false);
    if (!mounted) return;
    context.go('/login');
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(page.backgroundImage, fit: BoxFit.cover),
                    // Dark gradient overlay for readability
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Color(0xCC0A0A14),
                            Color(0xFF0A0A14),
                          ],
                          stops: [0.4, 0.7, 1.0],
                        ),
                      ),
                    ),
                    // Content
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 0, 24, 160),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              page.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              page.description,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 15,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Page indicators
          Positioned(
            left: 0,
            right: 0,
            bottom: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) {
                final bool isActive = index == _currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: isActive ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white70,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
          ),

          // Continue button
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2556D6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () async {
                if (_currentPage < _pages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                } else {
                  await _finishOnboarding();
                }
              },
              child: Text(
                _currentPage < _pages.length - 1 ? 'Continue' : 'Get Started',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardPageData {
  final String title;
  final String description;
  final String backgroundImage;

  const _OnboardPageData({
    required this.title,
    required this.description,
    required this.backgroundImage,
  });
}
