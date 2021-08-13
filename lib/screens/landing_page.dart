import 'dart:async';

import 'package:byteinc/screens/onboarding.dart';
import 'package:byteinc/screens/sign_in.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(title: '', subtitle: '', image: '',),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(color: Colors.white,
        image: DecorationImage(
          image: AssetImage(
            'assets/landing.jpg',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
