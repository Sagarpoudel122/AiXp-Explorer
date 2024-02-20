import 'package:e2_explorer/src/features/profile/presentation/widgets/client_info_section.dart';
import 'package:e2_explorer/src/features/profile/presentation/widgets/username_password.dart';

import 'package:e2_explorer/src/styles/color_styles.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: ColorStyles.secondaryColor,
              borderRadius: BorderRadius.circular(8)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                child: Text("Profile"),
              ),
              Spacer(),
              SizedBox(
                width: double.maxFinite,
                child: Row(
                  children: [
                    Spacer(),
                    ProifleUsernamePasswordSection(),
                    SizedBox(width: 16),
                    ClientInfoSection(),
                    Spacer(),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
