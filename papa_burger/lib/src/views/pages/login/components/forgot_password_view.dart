import 'package:flutter/material.dart';
import 'package:papa_burger/src/restaurant.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: const KText(
          text: 'Forgot password?',
          size: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
