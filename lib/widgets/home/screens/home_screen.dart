import 'package:flutter/material.dart';
import 'package:timer_application/widgets/home/screens/home_page.dart';

class HomeScreen extends StatelessWidget {
  final String title;
  const HomeScreen({super.key,required this.title});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(title: title),
    );
  }
}