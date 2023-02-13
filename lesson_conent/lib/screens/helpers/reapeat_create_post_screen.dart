import 'package:flutter/material.dart';

class RepeatCreatePostScreen extends StatefulWidget {
  const RepeatCreatePostScreen({Key? key}) : super(key: key);

  @override
  State<RepeatCreatePostScreen> createState() => _RepeatCreatePostScreenState();
}

class _RepeatCreatePostScreenState extends State<RepeatCreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('repeat your post')),
    );
  }
}
