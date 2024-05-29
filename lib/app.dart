import 'package:crud_assignment/screen/home_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XM Week 3',
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}