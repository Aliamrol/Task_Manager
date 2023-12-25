import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/Screens/NewTask.dart';

class floatingPoint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _floatingPoint();
}

class _floatingPoint extends State<floatingPoint> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => newTaskScreen()));
      },
      child: Icon(CupertinoIcons.add),
      backgroundColor: Colors.black,
    );
  }
}
