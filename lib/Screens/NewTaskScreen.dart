import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Task.dart';

class newTaskScreen extends StatefulWidget {
  late Function AddNewTask;

  newTaskScreen({required this.AddNewTask});

  @override
  State<StatefulWidget> createState() => _newTaskScreen();
}

class _newTaskScreen extends State<newTaskScreen> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String title_ = "";
    String description_ = "";

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(CupertinoIcons.chevron_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("NEW TASK"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: TextField(
              controller: controllerTitle,
              restorationId: "mmd",
              decoration: InputDecoration(hintText: "enter title: "),
              onChanged: (value) {
                title_ = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: TextField(
              controller: controllerDescription,
              decoration: InputDecoration(hintText: "enter description: "),
              onChanged: (value) {
                description_ = value;
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.done),
        onPressed: () {
          setState(() {
            if (title_ != "") {
              Task task = Task(
                  title: title_,
                  id: DateTime.now().microsecondsSinceEpoch,
                  description: description_);
              widget.AddNewTask(task);
              controllerTitle.clear();
              controllerTitle.clear();
              Navigator.pop(context);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text("Please enter the title"),
                    );
                  });
            }
          });
        },
      ),
    );
  }
}
