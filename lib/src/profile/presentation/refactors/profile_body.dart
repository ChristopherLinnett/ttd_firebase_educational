import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:ttd_firebase_educational/core/common/app/providers/user_provider.dart';
import 'package:ttd_firebase_educational/core/res/colours.dart';
import 'package:ttd_firebase_educational/core/res/media_res.dart';
import 'package:ttd_firebase_educational/src/profile/presentation/views/widgets/user_info_card.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      IconlyLight.document,
                      size: 24,
                      color: Color(0xFF767DFF),
                    ),
                    iconColour: Colours.physicsTileColour,
                    title: 'Courses',
                    value: user!.enrolledCourseIds.length.toString(),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UserInfoCard(
                    icon: Image.asset(
                      MediaRes.scoreboard,
                      height: 24,
                      width: 24,
                    ),
                    iconColour: Colours.languageTileColour,
                    title: 'Score',
                    value: user.points.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      IconlyLight.user,
                      color: Color(0xFF56AEFF),
                      size: 24,
                    ),
                    iconColour: Colours.biologyTileColour,
                    title: 'Followers',
                    value: user.followers.length.toString(),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: UserInfoCard(
                    icon: const Icon(
                      IconlyLight.user,
                      size: 24,
                      color: Color(
                        0xFFFF84AA,
                      ),
                    ),
                    iconColour: Colours.chemistryTileColour,
                    title: 'Following',
                    value: user.following.length.toString(),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
