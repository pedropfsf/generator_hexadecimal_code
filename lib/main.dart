import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math';
import 'widgets/button.dart';
import 'widgets/center_text.dart';

main() => runApp(const App());

class AppState extends State<App> {
  Color mainColor = const Color(0xFFAAAAAA);
  Color iconColor = Colors.black87;
  String message = '';

  Function getRandomColor = () => Random().nextInt(255);

  void generateColor() {
    final red = getRandomColor();
    final green = getRandomColor();
    final blue = getRandomColor();


    setState(() {
      mainColor = Color.fromARGB(255, red, green, blue);
    });
  }

  String getOldHex() {
    String hexadecimal = mainColor.value.toRadixString(16).toUpperCase();

    while (hexadecimal.length < 8) {
      hexadecimal = '0$hexadecimal';
    }

    if (hexadecimal.startsWith('FF')) {
      hexadecimal = hexadecimal.substring(2);
    }

    return '#$hexadecimal';
  }

  copy() {
    Clipboard.setData(ClipboardData(text: getOldHex()));
    setState(() {
      iconColor = Colors.green;
      message = 'Cor copiada com sucesso :D';
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        iconColor = Colors.black87;
        message = '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: mainColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CenterText(text: getOldHex()),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: copy,
                    child: Icon(
                      Icons.assignment,
                      size: 48,
                      color: iconColor,
                    )
                  )
                ]
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Button(
                  title: 'Gerar uma cor',
                  onPressed: generateColor,
                )
              ),
              Visibility(
                visible: message.isNotEmpty,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      )
                    )
                  ]
                )
              ),
            ],
          ),
        )
      )
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}