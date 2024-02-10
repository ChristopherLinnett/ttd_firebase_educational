import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';
import 'package:ttd_firebase_educational/core/res/colours.dart';
import 'package:ttd_firebase_educational/core/res/fonts.dart';
import 'package:ttd_firebase_educational/src/on_boarding/domain/entities/page_content.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({required this.pageContent, super.key});
  final PageContent pageContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(pageContent.image, height: context.height * 0.4),
        SizedBox(
          height: context.height * .05,
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              Text(
                pageContent.title,
                textAlign: TextAlign.center,
                style: context.textTheme.displaySmall?.copyWith(
                  fontFamily: Fonts.aeonik,
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: context.height * .05,
              ),
              Text(
                pageContent.description,
                textAlign: TextAlign.center,
                style: context.textTheme.labelLarge?.copyWith(fontSize: 14),
              ),
              SizedBox(
                height: context.height * .05,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 17,
                  ),
                  backgroundColor: Colours.primaryColour,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  context.read<OnBoardingCubit>().cacheFirstTimer();
                },
                child: Text(
                  'Get Started!',
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontFamily: Fonts.aeonik),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
