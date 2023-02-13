import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/components/edit_screen.dart';
import 'package:lesson_conent/screens/components/report_screen.dart';
import 'package:lesson_conent/screens/components/update_screen.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late bool isTeacher = false;
    return PopupMenuButton(
      onSelected: (value) {
        if (value == 'Edit') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EditScreen(),
            ),
          );
        }
        if (value == 'Update') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const UpdateScreen(),
            ),
          );
        }
        if (value == 'Report') {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ReportScreen(),
            ),
          );
        }
      },
      itemBuilder: (context) => isTeacher
          ? [
              const PopupMenuItem(
                value: 'Edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'Update',
                child: Text('Update'),
              ),
            ]
          : [
              const PopupMenuItem(
                value: 'Report',
                child: Text('Report Abuse'),
              ),
            ],
    );
  }
}
