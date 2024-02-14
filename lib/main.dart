import 'package:d2_touch/d2_touch.dart';
import 'package:dhis2_flutter/ui/splashscreen.dart';
import 'package:flutter/material.dart';
import 'main.reflectable.dart';

late D2Touch d2repository;
void main() async {
  initializeReflectable();
  WidgetsFlutterBinding.ensureInitialized();
  d2repository = await D2Touch.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
