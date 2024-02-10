import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ttd_firebase_educational/core/common/widgets/gradient_background.dart';
import 'package:ttd_firebase_educational/core/res/media_res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: SafeArea(
          child: Center(
            child: Lottie.asset(
              MediaRes.pageUnderConstruction,
            ),
          ),
        ),
      ),
    );
  }
}
