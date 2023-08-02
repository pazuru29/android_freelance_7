import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/settings_screen/widgets/settings_button.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  bool nightMod = false;

  @override
  Widget buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const SecondaryAppBar(
            title: 'Settings',
            subtitle: 'Change settings',
          ),
          const Gap(40),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         Container(
          //           padding: const EdgeInsets.all(8),
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(100),
          //             color: AppColors.layer1,
          //           ),
          //           child: SvgPicture.asset(AppIcons.icMoon),
          //         ),
          //         const Gap(12),
          //         const AppText(
          //           text: 'Dark mode',
          //           style: AppTextStyles.bodyRegular,
          //         ),
          //       ],
          //     ),
          //     Switch(
          //       value: nightMod,
          //       activeTrackColor: Colors.green,
          //       inactiveTrackColor: AppColors.layer2,
          //       inactiveThumbColor: Colors.white,
          //       trackOutlineColor: MaterialStateProperty.resolveWith(
          //         (states) {
          //           return Colors.transparent;
          //         },
          //       ),
          //       onChanged: (value) {
          //         setState(() {
          //           nightMod = value;
          //         });
          //       },
          //     ),
          //   ],
          // ),
          // const Gap(8),
          // Container(
          //   height: 1,
          //   color: AppColors.layer2,
          // ),
          SettingsButton(
            assetName: AppIcons.icShield,
            title: 'Privacy Policy',
            onPressed: () {},
          ),
          Container(
            height: 1,
            color: AppColors.layer2,
          ),
          SettingsButton(
            assetName: AppIcons.icDelete,
            title: 'Clear data',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
