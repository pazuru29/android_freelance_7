import 'package:android_freelance_7/data/app_storage.dart';
import 'package:android_freelance_7/ui/components/app_bar/secondary_app_bar.dart';
import 'package:android_freelance_7/ui/components/base_screen.dart';
import 'package:android_freelance_7/ui/screens/sport/sport_types_screen/widgets/sport_type_card.dart';
import 'package:android_freelance_7/utils/app_strings.dart';
import 'package:android_freelance_7/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SportTypesScreen extends BaseScreen {
  const SportTypesScreen({super.key});

  @override
  State<SportTypesScreen> createState() => _SportTypesScreenState();
}

class _SportTypesScreenState extends BaseScreenState<SportTypesScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const SecondaryAppBar(
            title: AppStrings.sport,
            subtitle: AppStrings.sportSubtitle,
          ),
          const Gap(24),
          Flexible(
            child: GridView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: AppStorage.listOfSportTypes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 12,
                childAspectRatio: 180 / 122,
              ),
              itemBuilder: (context, index) {
                return SportTypeCard(
                  assetName: AppStorage.listOfSportTypes[index].assetName,
                  title: AppStorage.listOfSportTypes[index].title,
                  onPressed: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
