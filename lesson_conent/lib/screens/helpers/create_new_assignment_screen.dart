import 'package:flutter/material.dart';

class CreateNewAssignmentScreen extends StatefulWidget {
  const CreateNewAssignmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewAssignmentScreen> createState() =>
      _CreateNewAssignmentScreenState();
}

class _CreateNewAssignmentScreenState
    extends State<CreateNewAssignmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('create new assignment post')),
    );
  }
}
