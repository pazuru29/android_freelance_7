import 'package:android_freelance_7/controllers/history_controller.dart';
import 'package:android_freelance_7/controllers/simple_score_bar_controller.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_create_controller.dart';
import 'package:android_freelance_7/controllers/sport_controllers/sport_game_controller.dart';
import 'package:android_freelance_7/controllers/workouts_controller.dart';
import 'package:android_freelance_7/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

void initControllers() {
  Get.lazyPut(() => SimpleScoreBarController());
  Get.lazyPut(() => WorkoutsController());
  Get.lazyPut(() => SportCreateController());
  Get.lazyPut(() => SportGameController());
  Get.lazyPut(() => HistoryController());
}
