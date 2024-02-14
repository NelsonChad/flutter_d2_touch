import 'dart:async';

import 'package:dhis2_flutter/main.dart';
import 'package:dhis2_flutter/ui/home.dart';
import 'package:dhis2_flutter/ui/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 150),
            Text("DHIS2 SDK", style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 30),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  initApp() async {
    bool isAuth = await d2repository.authModule.isAuthenticated();

    Timer(const Duration(seconds: 3), () {
      // Navigate to the main screen after 3 seconds

      if (isAuth) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }
}
