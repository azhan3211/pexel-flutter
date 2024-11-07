import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pexel/dependency_injection/repository_module.dart';
import 'package:pexel/presentation/screen/main_screen.dart';

void main() async {
  setupRepositoryDI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pexel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
