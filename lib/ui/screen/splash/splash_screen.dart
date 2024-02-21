import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../conustant/my_colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}
class _SplashScreen extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    time();
  }

  time() async {
    await Timer(
      const Duration(seconds: 5),
          () {
        Navigator.pushNamedAndRemoveUntil(
            context, "/change_language_screen", ModalRoute.withName('/change_language_screen'));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.MainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset('assets/login_img.svg'),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 50),
            child: Center(
              child: JumpingDots(
                color: MyColors.LoaderColor,
                radius: 10,
                numberOfDots: 3,
                animationDuration: const Duration(milliseconds: 200),
              ),
            ),
          )
        ],
      ),
    );
  }

}