import 'package:flutter/material.dart';

class AssignmentTaskScreen extends StatefulWidget {
  const AssignmentTaskScreen({Key? key}) : super(key: key);

  @override
  State<AssignmentTaskScreen> createState() => _AssignmentTaskScreenState();
}

class _AssignmentTaskScreenState extends State<AssignmentTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('here is your assignment task')),
    );
  }
}
