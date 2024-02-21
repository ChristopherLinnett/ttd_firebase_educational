import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text('Sign In Screen', style: context.textTheme.bodyLarge?.copyWith(color: Colors.white),),
      ),
    );
  }
}
