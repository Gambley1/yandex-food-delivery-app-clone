import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/create_material_screen.dart';
import 'package:lesson_conent/screens/tasks_manage_screen.dart';
import 'package:lesson_conent/screens/lesson_stream_screen.dart';
import 'package:lesson_conent/screens/create_assignment_screen.dart';
import '../../constants/colors.dart';
import '../question_create_screen.dart';
import 'menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  late bool isTeacher = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final screens = [
      const LessonStreamScreen(),
      const TasksManageScreen(),
      const LessonStreamScreen(),
    ];
    return Scaffold(
      floatingActionButton: isTeacher
          ? currentIndex == 1
              ? FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    buildBottomSheet(context, size);
                  },
                  child: Icon(
                    Icons.add,
                    size: 28,
                    color: Colors.blue[800],
                  ),
                )
              : Container()
          : Container(),
      drawer: const MenuDrawer(),
      body: screens[currentIndex],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: kPrimaryColor,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      iconSize: 30,
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(
          () {
            currentIndex = index;
          },
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_rounded),
          label: "Лента",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          label: "Задания",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_alt),
          label: "Учащиеся",
        ),
      ],
    );
  }

  Future<dynamic> buildBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 3,
                  width: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Center(
                child: Text(
                  'Создать задание',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: const Icon(
                  Icons.assignment,
                  color: Colors.black,
                ),
                title: const Text('Задание'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateAssignmentScreen(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: const Icon(
                  Icons.question_mark_rounded,
                  color: Colors.black,
                ),
                title: const Text('Вопрос'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const QuestionCreateScreen(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: const Icon(
                  Icons.auto_stories_rounded,
                  color: Colors.black,
                ),
                title: const Text('Материал урока'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateMaterialScreen(),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey,
                  height: 1,
                  width: size.width * 0.9,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: const Icon(
                  Icons.rotate_90_degrees_ccw_rounded,
                  color: Colors.black,
                ),
                title: const Text('Повторно использовать пост'),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: const Icon(
                  Icons.topic_rounded,
                  color: Colors.black,
                ),
                title: const Text('Тема'),
                onTap: () {},
              ),
            ),
          ],
        );
      },
    );
  }
}
