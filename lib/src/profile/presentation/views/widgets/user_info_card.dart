import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    required this.icon,
    required this.iconColour,
    required this.title,
    required this.value,
    super.key,
  });

  final Widget icon;
  final Color iconColour;
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 156,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFE4E6EA),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(color: iconColour, shape: BoxShape.circle),
            child: Center(child: icon),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
              ),
              Text(
                value,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
