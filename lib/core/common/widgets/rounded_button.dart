
import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';
import 'package:ttd_firebase_educational/core/res/colours.dart';
import 'package:ttd_firebase_educational/core/res/fonts.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.onPressed,
    required this.text,
    super.key,
  });
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 17,
        ),
        backgroundColor: Colours.primaryColour,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: context.textTheme.bodyLarge?.copyWith(fontFamily: Fonts.aeonik),
      ),
    );
  }
}
