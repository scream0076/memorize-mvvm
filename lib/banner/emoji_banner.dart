import 'package:flutter/material.dart';

class EmojiBanner extends StatelessWidget {
  const EmojiBanner({super.key, required this.gradientColor});

  final List<Color> gradientColor;

  @override
  Widget build(context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: gradientColor
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('M E M', style: TextStyle(fontSize: 35, color: Colors.white),),
              const SizedBox(width: 5),
              Image.asset('images/happy.png', height: 40, width: 40,),
              const SizedBox(width: 5),
              const Text('R I Z E', style: TextStyle(fontSize: 35, color: Colors.white),),
            ],
          ),
        ),
      ],
    );
  }
}