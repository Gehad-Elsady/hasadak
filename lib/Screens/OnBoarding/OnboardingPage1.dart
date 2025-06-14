import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hasadak/photos/images.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6EDE8A),
            Color(0xFF4AD66D),
            Color(0xFF155D27),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Photos.onBoarding1, height: 300),
            const SizedBox(height: 30),
             Text(
              'onboarding1_title'.tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
             Text(
              'onboarding1_subtitle'.tr(),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
