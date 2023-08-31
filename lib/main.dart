import 'package:flutter/material.dart';
import 'package:memorize_mvvm/memorize_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return const MaterialApp(
      home: MemorizeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}