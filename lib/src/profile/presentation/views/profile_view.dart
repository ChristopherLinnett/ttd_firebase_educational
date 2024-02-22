import 'package:flutter/material.dart';
import 'package:ttd_firebase_educational/core/common/widgets/gradient_background.dart';
import 'package:ttd_firebase_educational/core/res/media_res.dart';
import 'package:ttd_firebase_educational/src/profile/presentation/refactors/profile_body.dart';
import 'package:ttd_firebase_educational/src/profile/presentation/refactors/profile_header.dart';
import 'package:ttd_firebase_educational/src/profile/presentation/views/widgets/profile_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const ProfileAppBar(),
      body: GradientBackground(
        image: MediaRes.profileGradientBackground,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            ProfileHeader(),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
