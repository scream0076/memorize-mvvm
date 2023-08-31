import 'package:flutter/material.dart';

class NewGameButton extends StatefulWidget {
  const NewGameButton({super.key, required this.newGame});

  final void Function() newGame;

  @override
  State<NewGameButton> createState() {
    return _NewGameButtonState();
  }
}

class _NewGameButtonState extends State<NewGameButton> {
  bool onPress = false;

  @override
  Widget build(context) {
    return GestureDetector(
      onTapUp: (value) {
        setState(() {
          onPress = false;
        });
        widget.newGame();
      },
      onTapDown: (value) {
        setState(() {
          onPress = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 30,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
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
            Text('N E W  G A M E', style: TextStyle(fontSize: 12, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}