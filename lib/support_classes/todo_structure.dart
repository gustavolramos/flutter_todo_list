import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learning_todo_lists/support_classes/todo_content.dart';

class ToDoStructure extends StatelessWidget {
  const ToDoStructure({
    Key? key,
    required this.toDoContent,
    required this.onDelete,
  }) : super(key: key);

  final ToDoContent toDoContent;
  final Function(ToDoContent) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  DateFormat('dd/MM/yy - HH:mm')
                      .format(toDoContent.dateTime),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey.shade700)),
              Text(toDoContent.title,
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
          Column(
            children: [
              IconButton(
                iconSize: 20,
                onPressed: (){
                  onDelete(toDoContent);
                  },
                icon: const Icon(Icons.delete),
                focusColor: Colors.red.shade800,
                hoverColor: Colors.red.shade800,
                disabledColor: Colors.grey.shade700,
                color: Colors.red,
                tooltip: 'delete',
              )
            ],
          )
        ],
      ),
    );
  }
}