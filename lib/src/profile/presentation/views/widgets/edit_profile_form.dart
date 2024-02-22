import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';
import 'package:ttd_firebase_educational/core/extensions/string_extension.dart';
import 'package:ttd_firebase_educational/src/profile/presentation/views/widgets/edit_profile_form_field.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.fullNameController,
    required this.emailController,
    required this.bioController,
    required this.passwordController,
    required this.oldPasswordController,
    super.key,
  });

  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController bioController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EditProfileFormField(
          controller: fullNameController,
          fieldTitle: 'FULL NAME',
          hintText: context.user?.fullName,
        ),
        EditProfileFormField(
          controller: emailController,
          fieldTitle: 'EMAIL',
          hintText: context.user?.email.obscureEmail,
        ),
        EditProfileFormField(
          controller: oldPasswordController,
          fieldTitle: 'CURRENT PASSWORD',
          hintText: '********',
        ),
        StatefulBuilder(
          builder: (context, setState) {
            oldPasswordController.addListener(() => setState(() {}));
            return EditProfileFormField(
              controller: passwordController,
              fieldTitle: 'NEW PASSWORD',
              hintText: '********',
              readOnly: oldPasswordController.text.trim().isEmpty,
            );
          },
        ),
        EditProfileFormField(
          controller: bioController,
          fieldTitle: 'BIO',
          hintText: context.user?.bio,
        ),
      ],
    );
  }
}
