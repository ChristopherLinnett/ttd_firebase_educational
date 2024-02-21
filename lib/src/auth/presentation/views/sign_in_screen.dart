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
import 'package:ttd_firebase_educational/src/auth/presentation/views/sign_up_screen.dart';
import 'package:ttd_firebase_educational/src/auth/presentation/widgets/sign_in_form.dart';
import 'package:ttd_firebase_educational/src/dashboard/presentation/views/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state) {
          if (state is AuthError) {
            CoreUtils.showSnackBar(context, state.message);
          } else if (state is SignedIn) {
            context.read<UserProvider>().initUser(state.user as LocalUserModel);
            Navigator.pushReplacementNamed(context, Dashboard.routename);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign in to your account',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Baseline(
                      baseline: 100,
                      baselineType: TextBaseline.alphabetic,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            SignUpScreen.routeName,
                          );
                        },
                        child: const Text('Register Account?'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SignInForm(
                  emailController: emailController,
                  passwordController: passwordController,
                  formKey: formKey,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot-password');
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
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
                              SignInEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                    text: 'Sign In',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
