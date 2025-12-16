import 'package:flutter/material.dart';
import 'screens/intro_page_1.dart';
import 'screens/intro_page_2.dart';
import 'screens/login_signup_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics:
            const NeverScrollableScrollPhysics(), // Disable swipe to force button usage
        children: [
          IntroPage1(onContinue: _nextPage),
          IntroPage2(onContinue: _nextPage),
          const LoginSignupPage(),
        ],
      ),
    );
  }
}
