import 'package:flutter/material.dart';
import 'coffee_dashboard.dart';

void main() {
  runApp(const CoffeeApp());

}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coffee Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3E2723)),
        useMaterial3: true,
      ),
      home: const CoffeeDashboard(),
    );
  }
}