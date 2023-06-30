import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key, 
    required this.onPressed,
    required this.title
  });

  final Function() onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
      ),
      child: Text(title, style: const TextStyle(fontSize: 24)),
    );
  }
}