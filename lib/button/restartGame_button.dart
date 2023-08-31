import 'package:flutter/material.dart';

class RestartGameButton extends StatefulWidget {
  const RestartGameButton({super.key, required this.restart});

  final void Function() restart;

  @override
  State<RestartGameButton> createState() {
    return _RestartGameButtonState();
  }
}

class _RestartGameButtonState extends State<RestartGameButton> {
  bool onPress = false;

  @override
  Widget build(context) {
    return GestureDetector(
      
      onTapUp: (value) {
        setState(() {
          onPress = false;
        });
        widget.restart();
      },
      onTapDown: (value) {
        setState(() {
          onPress = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFFCC2B5E), Color(0xFF753A88)]
          ),
          boxShadow: onPress
            ? [
              BoxShadow(
                color: const Color(0xFF753A88).withOpacity(1),
                spreadRadius: 1,
                blurRadius: 15,
              ),
              BoxShadow(
                color: const Color(0xFFCC2B5E).withOpacity(1),
                spreadRadius: 1,
                blurRadius: 15,
              ),
            ]
            : []
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restart_alt, color: Colors.white, size: 40,),
          ],
        ),
      ),
    );
  }
}