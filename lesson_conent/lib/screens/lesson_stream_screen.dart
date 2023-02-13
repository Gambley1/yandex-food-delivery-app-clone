import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/widgets/add_new_post.dart';
import 'package:lesson_conent/screens/widgets/list_of_tasks_and_posts.dart';
import 'package:lesson_conent/screens/widgets/lesson_card.dart';

class LessonStreamScreen extends StatefulWidget {
  const LessonStreamScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LessonStreamScreen> createState() => _LessonStreamScreenState();
}

class _LessonStreamScreenState extends State<LessonStreamScreen> {
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
        const LessonCard(),
        const AddNewPost(),
        const ListOfTasksAndPosts(),
      ],
    );
  }
}
