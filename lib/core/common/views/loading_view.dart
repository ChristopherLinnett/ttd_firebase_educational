import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(
            context.colors.secondary,
          ),
        ),
      ),
    );
  }
}
