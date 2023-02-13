import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/assignment_task_screen.dart';
import 'package:lesson_conent/screens/widgets/pop_up_menu.dart';

class TasksManageScreen extends StatefulWidget {
  const TasksManageScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<TasksManageScreen> createState() => _TasksManageScreenState();
}

class _TasksManageScreenState extends State<TasksManageScreen> {
  late bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverAppBar(
          title: const Text('Алгебра'),
          floating: false,
          pinned: true,
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Container(width: size.width),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  iconColor: Colors.black,
                  title: const Text(
                    'Asd',
                    style: TextStyle(fontSize: 17),
                  ),
                  subtitle: const Text(
                    'Due Mon. 25, 2022, 19:00',
                    style: TextStyle(fontSize: 13),
                  ),
                  leading: isCompleted
                      ? CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[500],
                          child: const Icon(
                            Icons.list_alt_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                        )
                      : CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[900],
                          child: const Icon(
                            Icons.list_alt_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                  trailing: const PopUpMenu(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AssignmentTaskScreen(),
                      ),
                    );
                  },
                ),
              );
            }),
            childCount: 15,
          ),
        ),
      ],
    );
  }
}
