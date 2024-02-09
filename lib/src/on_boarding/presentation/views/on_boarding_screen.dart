import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_firebase_educational/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        
      },
    );
  }
}
