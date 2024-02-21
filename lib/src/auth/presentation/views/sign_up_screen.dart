import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          'Sign Up Screen',
          style: context.textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
