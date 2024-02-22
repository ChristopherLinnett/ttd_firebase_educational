import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';

class NestedBackButton extends StatelessWidget {
  const NestedBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        try {
          context.pop();
        } catch (_) {
          Navigator.of(context).pop();
        }
      },
      child: BackButton(
        onPressed: () {
          try {
            context.pop();
          } catch (_) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
