import 'package:android_freelance_7/ui/models/sport_type_model.dart';
import 'package:android_freelance_7/utils/app_images.dart';
import 'package:android_freelance_7/utils/app_strings.dart';

class AppStorage {
  static List<SportTypeModel> listOfSportTypes = [
    SportTypeModel(
      assetName: AppImages.imSoccer,
      title: AppStrings.soccer,
    ),
    SportTypeModel(
      assetName: AppImages.imBasketball,
      title: AppStrings.basketball,
    ),
    SportTypeModel(
      assetName: AppImages.imFootball,
      title: AppStrings.football,
    ),
    SportTypeModel(
      assetName: AppImages.imVolleyball,
      title: AppStrings.volleyball,
    ),
    SportTypeModel(
      assetName: AppImages.imHockey,
      title: AppStrings.hockey,
    ),
    SportTypeModel(
      assetName: AppImages.imTennis,
      title: AppStrings.tennis,
    ),
    SportTypeModel(
      assetName: AppImages.imChess,
      title: AppStrings.chess,
    ),
    SportTypeModel(
      assetName: AppImages.imHandball,
      title: AppStrings.handball,
    ),
  ];
}
