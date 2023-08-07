import 'package:android_freelance_7/controllers/app_navigator.dart';
import 'package:android_freelance_7/controllers/history_controller.dart';
import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/app_text.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/settings_screen/widgets/settings_button.dart';
import 'package:android_freelance_7/utils/app_colors.dart';
import 'package:android_freelance_7/utils/app_icons.dart';
import 'package:android_freelance_7/utils/app_text_style.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  final HistoryController _historyController = Get.find();

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
            onPressed: () {
              showDeleteDataDialog();
            },
          ),
        ],
      ),
    );
  }

  void showDeleteDataDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Center(
          child: AppText(
            text: 'Clear data',
            style: AppTextStyles.headerMedium,
            maxLines: null,
            align: TextAlign.center,
          ),
        ),
        content: const Center(
          child: AppText(
            text: 'Are you sure? All data will be discharged.',
            style: AppTextStyles.captionMedium,
            maxLines: null,
            align: TextAlign.center,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const AppText(
              text: 'Yes',
              style: AppTextStyles.headerMedium,
              color: AppColors.accentSecondary1,
            ),
            onPressed: () {
              _historyController.deleteData();
              AppNavigator.goBack(context);
            },
          ),
          CupertinoDialogAction(
            child: const AppText(
              text: 'No',
              style: AppTextStyles.headerMedium,
              color: AppColors.accentPrimary1,
            ),
            onPressed: () {
              AppNavigator.goBack(context);
            },
          ),
        ],
      ),
    );
  }
}
