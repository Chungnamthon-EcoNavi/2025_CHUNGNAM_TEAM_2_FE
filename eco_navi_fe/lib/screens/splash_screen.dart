import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 0), () {
      GoRouter.of(context).go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFAF3E0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: SvgPicture.asset('svg/eco_navi_logo.svg'),
          ),
        ],
      ),
    );
  }
}
