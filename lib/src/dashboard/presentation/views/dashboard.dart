import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routename = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          'Dashboard Screen',
          style: context.textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
