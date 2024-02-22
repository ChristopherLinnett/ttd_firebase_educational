import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttd_firebase_educational/core/common/widgets/gradient_background.dart';
import 'package:ttd_firebase_educational/core/common/widgets/nested_back_button.dart';
import 'package:ttd_firebase_educational/core/enums/update_user.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';
import 'package:ttd_firebase_educational/core/res/media_res.dart';
import 'package:ttd_firebase_educational/core/utils/core_utils.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:ttd_firebase_educational/src/profile/presentation/views/widgets/edit_profile_form.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bioController = TextEditingController();
  final oldPasswordController = TextEditingController();
  File? pickedImage;

  bool get nameChanged =>
      fullNameController.text.trim() != context.user?.fullName.trim();

  bool get emailChanged =>
      emailController.text.isNotEmpty &&
      emailController.text.trim() != context.user?.email;

  bool get bioChanged => bioController.text.trim() != context.user?.bio?.trim();

  bool get imageChanged => pickedImage != null;

  bool get passwordChanged => passwordController.text.isNotEmpty;

  bool get nothingChanged =>
      !nameChanged &&
      !emailChanged &&
      !bioChanged &&
      !imageChanged &&
      !passwordChanged;

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      pickedImage = File(image.path);
    });
  }

  @override
  void initState() {
    fullNameController.text = context.user?.fullName.trim() ?? '';
    bioController.text = context.user?.bio?.trim() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    bioController.dispose();
    oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          CoreUtils.showSnackBar(context, 'Profile Updated Successfully');
          context.pop();
        } else if (state is AuthError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: const NestedBackButton(),
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (nothingChanged) context.pop();
                  final bloc = context.read<AuthBloc>();
                  if (passwordChanged) {
                    if (oldPasswordController.text.trim().isEmpty) {
                      CoreUtils.showSnackBar(
                        context,
                        'Please enter your old password',
                      );
                      return;
                    }
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.password,
                        userData: jsonEncode({
                          'oldPassword': oldPasswordController.text.trim(),
                          'newPassword': passwordController.text.trim(),
                        }),
                      ),
                    );
                  }
                  if (nameChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.displayName,
                        userData: fullNameController.text.trim(),
                      ),
                    );
                  }
                  if (bioChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.bio,
                        userData: bioController.text.trim(),
                      ),
                    );
                  }
                  if (emailChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.email,
                        userData: emailController.text.trim(),
                      ),
                    );
                    if (bioChanged) {
                      bloc.add(
                        UpdateUserEvent(
                          action: UpdateUserAction.bio,
                          userData: bioController.text.trim(),
                        ),
                      );
                    }
                  }
                  if (imageChanged) {
                    bloc.add(
                      UpdateUserEvent(
                        action: UpdateUserAction.profilePic,
                        userData: pickedImage,
                      ),
                    );
                  }
                },
                child: state is AuthLoading
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : StatefulBuilder(
                        builder: (_, refreshTextWidget) {
                          fullNameController
                              .addListener(() => refreshTextWidget(() {}));
                          bioController
                              .addListener(() => refreshTextWidget(() {}));
                          emailController
                              .addListener(() => refreshTextWidget(() {}));
                          passwordController
                              .addListener(() => refreshTextWidget(() {}));

                          return Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: nothingChanged
                                  ? Colors.grey
                                  : Colors.blueAccent,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          body: GradientBackground(
            image: MediaRes.profileGradientBackground,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Builder(
                  builder: (context) {
                    final user = context.user!;
                    final userImage =
                        user.profilePic == null || user.profilePic!.isEmpty
                            ? null
                            : user.profilePic;
                    return Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: pickedImage != null
                              ? FileImage(pickedImage!)
                              : userImage != null
                                  ? NetworkImage(userImage)
                                  : const AssetImage(MediaRes.user)
                                      as ImageProvider,
                          colorFilter: pickedImage == null
                              ? ColorFilter.mode(
                                  Colors.black.withOpacity(.75),
                                  BlendMode.darken,
                                )
                              : null,
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(
                            pickedImage != null || user.profilePic != null
                                ? Icons.edit
                                : Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          onPressed: pickImage,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    'We recommend an image of at least 400px x 400px',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Color(0xFF777E90)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                EditProfileForm(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  bioController: bioController,
                  passwordController: passwordController,
                  oldPasswordController: oldPasswordController,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
