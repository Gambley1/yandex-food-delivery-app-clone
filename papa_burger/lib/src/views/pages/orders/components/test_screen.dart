import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const KText(
            text: 'test',
          ),
        ),
      ),
    );
  }
}
