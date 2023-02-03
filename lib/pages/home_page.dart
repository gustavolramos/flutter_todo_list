import 'package:flutter/material.dart';
import 'package:learning_todo_lists/pages/page_title.dart';
import 'package:learning_todo_lists/pages/page_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30.0),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
            children: const [
              PageTitle(),
              PageBody(),
            ],
        ),
      ),
    );
  }
}