import 'package:flutter/material.dart';

class CreateNewCommentScreen extends StatefulWidget {
  const CreateNewCommentScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewCommentScreen> createState() => _CreateNewCommentScreenState();
}

class _CreateNewCommentScreenState extends State<CreateNewCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('add your comment')),
    );
  }
}
