import 'package:flutter/material.dart';

class LessonCard extends StatefulWidget {
  const LessonCard({
    Key? key,
  }) : super(key: key);

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  late bool lessonHasSubtitle = true;
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
            child: Stack(
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                ),
                const Positioned(
                  bottom: 28,
                  left: 12,
                  child: Text(
                    'Asd',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
                lessonHasSubtitle
                    ? const Positioned(
                        bottom: 8,
                        left: 12,
                        child: Text(
                          'Asd',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
        childCount: 1,
      ),
    );
  }
}
