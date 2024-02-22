import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/common/widgets/i_field.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    required this.controller,
    required this.fieldTitle,
    super.key,
    this.hintText,
    this.readOnly = false,
  });

  final String fieldTitle;
  final String? hintText;
  final TextEditingController controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            fieldTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IField(
          controller: controller,
          readOnly: readOnly,
          hintText: hintText,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
