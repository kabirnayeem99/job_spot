import 'package:flutter/material.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);
}

abstract class BaseScreenState<Screen extends BaseScreen>
    extends State<Screen> {
  String appBarTitle();

  void isBackButtonShown(bool isBack) {
  }
}
