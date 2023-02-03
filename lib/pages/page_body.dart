import 'package:flutter/material.dart';
import 'package:learning_todo_lists/respositories/todo_repository.dart';
import 'package:learning_todo_lists/support_classes/todo_content.dart';
import '../support_classes/todo_structure.dart';

class PageBody extends StatefulWidget {
  const PageBody({Key? key}) : super(key: key);

  @override
  State<PageBody> createState() => _PageBodyState();
}

class _PageBodyState extends State<PageBody> {
  final TextEditingController todoController = TextEditingController();
  final ToDoRepository toDoRepository = ToDoRepository();
  String? errorText;

  List<ToDoContent> toDoList = [];

  @override
  void initState() {
    super.initState();

    toDoRepository.getToDoList().then((value) {
      setState(() {
        toDoList = value;
      });
    });
  }

  void onDelete(ToDoContent toDoContent) {
    var deletedTodo = toDoContent;
    var deletedToDoPosition = toDoList.indexOf(toDoContent);

    setState(() {
      toDoList.remove(toDoContent);
    });
    toDoRepository.saveToDoList(toDoList);

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${toDoContent.title} was successfully deleted.',
          style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.grey.shade700,
      action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              toDoList.insert(deletedToDoPosition, deletedTodo);
            });
            toDoRepository.saveToDoList(toDoList);
          }),
      duration: const Duration(seconds: 5),
    ));
  }

  void showDeleteConfirmationModal() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Deleting all tasks',
                  style: Theme.of(context).textTheme.titleLarge),
              content: Text('Are you sure you want to delete all tasks?',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey.shade800)),
              actions: [
                TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No',
                        style: TextStyle(color: Colors.white))),
                TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      Navigator.of(context).pop();
                      deleteAllTasks();
                    },
                    child: const Text('Yes',
                        style: TextStyle(color: Colors.white))),
              ],
            ));
  }

  void deleteAllTasks() {
    setState(() {
      toDoList.clear();
    });
    toDoRepository.saveToDoList(toDoList);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 4,
                    child: TextField(
                        controller: todoController,
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.titleLarge,
                        decoration: InputDecoration(
                            errorText: errorText,
                            labelText: 'Task',
                            hintText: 'Name your new task',
                            fillColor: Colors.grey,
                            border: const OutlineInputBorder()))),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        String todoText = todoController.text;

                        if (todoText.isEmpty) {
                          setState(() {
                            errorText = 'You need to type a task name';
                          });
                          return;
                        }

                        setState(() {
                          ToDoContent newTodo = ToDoContent(
                              title: todoText, dateTime: DateTime.now());
                          toDoList.add(newTodo);
                          errorText = null;
                          FocusManager.instance.primaryFocus?.unfocus();
                        });
                        todoController.clear();
                        toDoRepository.saveToDoList(toDoList);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.all(16)),
                      child: const Icon(Icons.add, size: 30)),
                )
              ]),
          Expanded(
              flex: 4,
              child: ListView(shrinkWrap: true, children: [
                for (ToDoContent newToDo in toDoList)
                  ToDoStructure(
                    toDoContent: newToDo,
                    onDelete: onDelete,
                  )
              ])),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: Row(
              children: [
                Expanded(
                    child: Text('You have ${toDoList.length} tasks to do',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black))),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showDeleteConfirmationModal();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.all(16)),
                  child: const Text('Clean all',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}