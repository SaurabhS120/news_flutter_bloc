import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  PreferredSizeWidget buildAppBar();

  Widget buildBody();
}