import 'package:android_freelance_7/ui/screens/history_screen/history_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/simple_scorebar/create_simple_score_bar_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/simple_scorebar/edit_simple_scorebar_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/simple_scorebar/finished_simple_score_bar_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/simple_scorebar/simple_score_bar_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/workouts_scorebar/create_workouts_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/workouts_scorebar/finished_workout_screen.dart';
import 'package:android_freelance_7/ui/screens/scorebars/workouts_scorebar/workouts_screen.dart';
import 'package:android_freelance_7/ui/screens/settings_screen/settings_screen.dart';
import 'package:android_freelance_7/ui/screens/sport/sport_types_screen/sport_types_screen.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goToSportTypesScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SportTypesScreen(),
      ),
    );
  }

  static void goToSettingsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  static void goToHistoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }

  static void goToCreateSimpleScoreBarScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateSimpleScoreBarScreen(),
      ),
    );
  }

  static void replaceToSimpleScoreBarScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleScoreBarScreen(),
      ),
    );
  }

  static void goToSimpleScoreBarScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SimpleScoreBarScreen(),
      ),
    );
  }

  static void goToEditSimpleScoreBarScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditSimpleScoreBarScreen(),
      ),
    );
  }

  static void replaceToFinishedSimpleScoreBarScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FinishedSimpleScoreBarScreen(),
      ),
    );
  }

  static void goToFinishedSimpleScoreBarScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FinishedSimpleScoreBarScreen(),
      ),
    );
  }

  static void goToCreateWorkoutsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateWorkoutsScreen(),
      ),
    );
  }

  static void replaceToWorkoutsScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const WorkoutsScreen(),
      ),
    );
  }

  static void goToWorkoutsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WorkoutsScreen(),
      ),
    );
  }

  static void replaceToFinishedWorkoutScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FinishedWorkoutScreen(),
      ),
    );
  }

  static void goToFinishedWorkoutScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FinishedWorkoutScreen(),
      ),
    );
  }
}
