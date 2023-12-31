import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Drawer.dart';
import 'package:task_manager/Screens/DeletedTasksScreen.dart';
import 'package:task_manager/floatingPoint.dart';
import 'package:task_manager/taskItem.dart';
import '../Task.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  List<Task> tasks = [
    Task(
      title: "Mina",
      id: 930,
    ),
  ];
  List<Task> tasksDone = [
    Task(title: "Ali", id: 905, isDone: true),
  ];
  List<Task> taskDeleted = [];

  AddFromTasksDoneToTask(int id) {
    setState(() {
      Task t = Task(title: "BUG Add from tasksDone to Task", id: 0000);
      for (int index = 0; index < tasksDone.length; index++) {
        if (tasksDone[index].id == id) {
          t = tasksDone[index];
        }
      }
      t.isDone = false;
      tasksDone.removeWhere((element) => element.id == id);
      tasks.add(t);
    });
  }

  DoneATask(int id) {
    setState(() {
      Task t = Task(title: "BUG Done a Task", id: 1111);
      for (int index = 0; index < tasks.length; index++) {
        if (tasks[index].id == id) {
          t = tasks[index];
        }
      }
      t.isDone = true;
      tasks.removeWhere((element) => element.id == id);
      tasksDone.add(t);
    });
  }

  AddNewTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  EditingTask(int id, String title, String description) {
    setState(() {
      for (Task t in tasks) {
        if (t.id == id) {
          t.title = title;
          t.description = description;
        }
      }
    });
  }

  DeleteTask(int id) {
    setState(() {
      taskDeleted.add(tasks.where((element) => element.id == id).toList()[0]);
      tasks = tasks.where((element) => element.id != id).toList();
    });
  }

  DeleteTaskDone(int id) {
    setState(() {
      taskDeleted
          .add(tasksDone.where((element) => element.id == id).toList()[0]);
      tasksDone = tasksDone.where((element) => element.id != id).toList();
    });
  }

  DeleteTaskSure(Task task) {
    setState(() {
      taskDeleted =
          taskDeleted.where((element) => element.id != task.id).toList();
    });
  }

  ReturnTask(Task task) {
    setState(() {
      Task t =
          taskDeleted.where((element) => element.id == task.id).toList()[0];
      taskDeleted =
          taskDeleted.where((element) => element.id != task.id).toList();
      if (t.isDone) {
        tasksDone.add(t);
      } else {
        tasks.add(t);
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < tasks.length; i++) {
      rows.add(SizedBox(
        height: 20,
      ));
      rows.add(TaskItem(
        title: tasks[i].title,
        isDone: tasks[i].isDone,
        description: tasks[i].description,
        id: tasks[i].id,
        tasks: this.tasks,
        tasksDone: this.tasksDone,
        AddFromTasksDoneToTask: this.AddFromTasksDoneToTask,
        DoneATask: this.DoneATask,
        editingTask: this.EditingTask,
        deleteTask: this.DeleteTask,
      ));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(
        tasks: this.tasks,
        tasksDone: this.tasksDone,
        AddFromTasksDoneToTask: this.AddFromTasksDoneToTask,
        DoneATask: this.DoneATask,
        editingTask: this.EditingTask,
        deleteTask: this.DeleteTaskDone,
      ),
      appBar: AppBar(
        title: const Text(
          "TO DO LIST",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => deletedTasksScreen(
                              deletedTasks: taskDeleted,
                              deleteTaskSure: DeleteTaskSure,
                              returnTask: ReturnTask)));
                },
                icon: Icon(
                  CupertinoIcons.delete,
                  color: Colors.black,
                )),
          )
        ],
        backgroundColor: Colors.grey[400],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              _scaffoldKey.currentState?.openDrawer();
            });
          },
        ),
      ),
      body: ListView(
        children: [
          ...rows,
        ],
      ),
      floatingActionButton: floatingPoint(AddNewTask: AddNewTask),
    );
  }
}
