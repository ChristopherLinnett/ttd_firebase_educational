import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ttd_firebase_educational/core/common/widgets/popup_item.dart';
import 'package:ttd_firebase_educational/core/extensions/context_extension.dart';
import 'package:ttd_firebase_educational/core/res/colours.dart';
import 'package:ttd_firebase_educational/core/services/injection_container.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Account',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          surfaceTintColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              onTap: () => context.push(const Placeholder()),
              child: const PopupItem(
                title: 'Edit Profile',
                icon: Icon(
                  Icons.edit,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            const PopupMenuItem<void>(
              // onTap: () => context.push(const Placeholder()),
              child: PopupItem(
                title: 'Notifications',
                icon: Icon(
                  IconlyLight.notification,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              onTap: () => context.push(const Placeholder()),
              child: const PopupItem(
                title: 'Help',
                icon: Icon(
                  Icons.help_outline_outlined,
                  color: Colours.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.grey[300],
                endIndent: 8,
                indent: 8,
              ),
            ),
            PopupMenuItem<void>(
              onTap: () async {
                final navigator = Navigator.of(context);
                await sl<FirebaseAuth>().signOut();
                unawaited(
                  navigator.pushNamedAndRemoveUntil(
                    '/',
                    (route) => false,
                  ),
                );
              },
              child: const PopupItem(
                title: 'Logout',
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
