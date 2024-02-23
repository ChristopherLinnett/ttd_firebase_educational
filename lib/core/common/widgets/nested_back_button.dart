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
      child: Tooltip(
        message: context.tabNavigator.previousPageType,
        child: IconButton(
          icon: Icon(
            context.theme.platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios_new
                : Icons.arrow_back,
          ),
          onPressed: () {
            try {
              context.pop();
            } catch (_) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }
}
