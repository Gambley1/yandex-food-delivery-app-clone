import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/assignment_task_screen.dart';
import 'package:lesson_conent/screens/helpers/create_class_comment_screen.dart';
import 'package:lesson_conent/screens/widgets/pop_up_menu.dart';

class ListOfTasksAndPosts extends StatefulWidget {
  const ListOfTasksAndPosts({Key? key}) : super(key: key);

  @override
  State<ListOfTasksAndPosts> createState() => _ListOfTasksAndPostsState();
}

class _ListOfTasksAndPostsState extends State<ListOfTasksAndPosts> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Card(
            elevation: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AssignmentTaskScreen(),
                          ),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.48),
                              blurRadius: .2,
                              spreadRadius: .12,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              isThreeLine: false,
                              textColor: Colors.black,
                              iconColor: Colors.black,
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue[900],
                                child: const Icon(
                                  Icons.assignment,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: const PopUpMenu(),
                              title: const Text(
                                'Assignment: Asd',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                'Mon. 23, 2022',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.48),
                                    blurRadius: .12,
                                    spreadRadius: .2,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              textColor: Colors.grey[600],
                              iconColor: Colors.black,
                              dense: true,
                              title: const Text(
                                'Add class comment...',
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateNewCommentScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: 5,
      ),
    );
  }
}
