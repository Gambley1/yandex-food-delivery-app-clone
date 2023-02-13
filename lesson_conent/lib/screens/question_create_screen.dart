import 'package:flutter/material.dart';
import 'package:lesson_conent/screens/components/home_screen.dart';

class QuestionCreateScreen extends StatefulWidget {
  const QuestionCreateScreen({Key? key}) : super(key: key);

  @override
  State<QuestionCreateScreen> createState() => _QuestionCreateScreenState();
}

class _QuestionCreateScreenState extends State<QuestionCreateScreen> {
  final TextEditingController questionTitleController = TextEditingController();
  final TextEditingController questiondescriptionController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    questionTitleController.dispose();
    questiondescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionTitleField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: questionTitleController,
      validator: (value) {
        if (value!.isEmpty) {
          return ('Название вопроса обязательно');
        }
        return null;
      },
      onSaved: (value) {
        questionTitleController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Название вопроса",
        hintStyle: TextStyle(fontSize: 23),
        hintMaxLines: 1,
      ),
    );

    final questionDescriptionField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      controller: questiondescriptionController,
      onSaved: (value) => questiondescriptionController.text = value!,
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        enabled: true,
        prefixIcon: Icon(Icons.description),
        prefixIconColor: Colors.black,
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Описание",
      ),
    );

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        child: const Text(
          "Подтвердить",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                questionTitleField,
                const SizedBox(
                  height: 10,
                ),
                questionDescriptionField,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: Text(
                                            'Тип вопроса',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.assignment,
                                            color: Colors.black,
                                          ),
                                          title: const Text('Короткий ответ'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.question_mark_rounded,
                                            color: Colors.black,
                                          ),
                                          title: const Text('Выбор'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: ListTile(
                              leading: const Icon(
                                Icons.question_mark_rounded,
                              ),
                              title: Row(
                                children: const [
                                  Text('Короткий ответ'),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                          const ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 72),
                            title: Text('asd'),
                          ),
                          const ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 72),
                            title: Text('asd'),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                            width: size.width,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(12.0),
                                  ),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                builder: (context) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Center(
                                          child: Text(
                                            'Тип вопроса',
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.assignment,
                                            color: Colors.black,
                                          ),
                                          title: const Text('Короткий ответ'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ListTile(
                                          leading: const Icon(
                                            Icons.question_mark_rounded,
                                            color: Colors.black,
                                          ),
                                          title: const Text('Выбор'),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const ListTile(
                              leading: Icon(Icons.date_range_rounded),
                              title: Text('Выбрать время'),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                            width: size.width,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const ListTile(
                              leading: Icon(
                                Icons.attachment_sharp,
                              ),
                              title: Text('Тема'),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.grey,
                            width: size.width,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: submitButton,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
