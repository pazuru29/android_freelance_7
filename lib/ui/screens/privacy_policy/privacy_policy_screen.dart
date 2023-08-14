import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends BaseScreen {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends BaseScreenState<PrivacyPolicyScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          FittedBox(
            child: SecondaryAppBar(
              title: 'Privacy policy',
            ),
          ),
        ],
      ),
    );
  }
}
