import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState<T extends BaseScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: needSafeArea()
          ? SafeArea(
              child: buildMain(context),
            )
          : buildMain(context),
    );
  }

  Widget buildMain(BuildContext context) {
    return const Placeholder();
  }

  bool needSafeArea() {
    return true;
  }
}
