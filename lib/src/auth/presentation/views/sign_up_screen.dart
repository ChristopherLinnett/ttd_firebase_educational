import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ttd_firebase_educational/core/common/app/providers/user_provider.dart';
import 'package:ttd_firebase_educational/core/common/widgets/gradient_background.dart';
import 'package:ttd_firebase_educational/core/common/widgets/rounded_button.dart';
import 'package:ttd_firebase_educational/core/res/fonts.dart';
import 'package:ttd_firebase_educational/core/res/media_res.dart';
import 'package:ttd_firebase_educational/core/utils/core_utils.dart';
import 'package:ttd_firebase_educational/src/auth/data/models/user_model.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/views/sign_in_screen.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/widgets/sign_up_form.dart';
import 'package:ttd_firebase_educational/src/dashboard/presentation/views/dashboard.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/sign-up';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(
              context,
              Dashboard.routename,
            );
          } else if (state is SignedUp) {
            SignInEvent(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        builder: (context, state) => GradientBackground(
          image: MediaRes.authGradientBackground,
          child: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const Text(
                  'Easy to learn, discover more skills',
                  style: TextStyle(
                    fontFamily: Fonts.aeonik,
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Sign up for an account',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        SignInScreen.routeName,
                      );
                    },
                    child: const Text('Already have an account?'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SignUpForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordController: confirmPasswordController,
                  fullNameController: fullNameController,
                  formKey: formKey,
                ),
                const SizedBox(
                  height: 20,
                ),
                if (state is AuthLoading)
                  const Center(child: CircularProgressIndicator.adaptive())
                else
                  RoundedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      FirebaseAuth.instance.currentUser?.reload();
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              SignUpEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                fullName: fullNameController.text.trim(),
                              ),
                            );
                      }
                    },
                    text: 'Sign Up',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
