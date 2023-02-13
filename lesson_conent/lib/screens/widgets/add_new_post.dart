import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/helpers/create_new_post_screen.dart';
import 'package:lesson_conent/screens/helpers/reapeat_create_post_screen.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
              child: Ink(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.35),
                        // offset: Offset.zero,
                        blurRadius: 6.0,
                        spreadRadius: .05,
                      ),
                    ]),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  minVerticalPadding: 30,
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue[900],
                    child: const Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RepeatCreatePostScreen(),
                        ),
                      );
                    },
                    icon: (const Icon(
                      Icons.refresh_rounded,
                    )),
                  ),
                  title: Text(
                    'Add new post...',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateNewPostScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }, childCount: 1),
    );
  }
}
