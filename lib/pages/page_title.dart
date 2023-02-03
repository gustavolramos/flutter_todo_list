import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 14.0, 0.0, 0.0),
      child: Row(
        children: [
          Text('My ToDo List', style: Theme.of(context).textTheme.headlineLarge)
        ],
      ),
    );
  }
}