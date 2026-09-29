import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_new_app/core/components/custom_btn.dart';
import 'package:my_new_app/core/components/custom_dots.dart';
import 'package:my_new_app/core/utils/app_assets.dart';
import 'package:my_new_app/core/utils/app_colors.dart';
import 'package:my_new_app/core/utils/app_paddings.dart';
import 'package:my_new_app/features/auth/data/models/onboarding_model.dart';
import 'package:my_new_app/core/helper/my_navigator.dart';
import 'package:my_new_app/features/auth/presentation/views/start_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


 

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingModel> _pages = const [
    OnboardingModel(
      image: 'assets/images/splash1.svg',
      title: 'Choose Products',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: 'assets/images/splash2.svg',
      title: 'Make Payment',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
    OnboardingModel(
      image: 'assets/images/splash3.svg',
      title: 'Get Your Order',
      description:
          'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
    ),
  ];

  void _goToStartScreen() {
    
    MyNavigator.goTo(context, toPage: const StartScreen(),type: NavigatorType.pushReplacement);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_currentIndex + 1}/${_pages.length}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: _goToStartScreen, 
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _pages[index].image,
                          height: 250,
                        ),
                        const SizedBox(height: 32),
                        Text(
                          _pages[index].title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _pages[index].description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.grey,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // زر Prev
                  _currentIndex > 0
                      ? TextButton(
                          onPressed: () {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: const Text(
                            'Prev',
                            style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        )
                      : const SizedBox(width: 50),

                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        width: _currentIndex == index ? 30 : 10,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? AppColors.primary
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      if (_currentIndex == _pages.length - 1) {
                        _goToStartScreen(); //    
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}