import 'package:flutter/material.dart';

import '../../Task.dart';

class taskItem extends StatelessWidget {
  final BuildContext context;
  final int index;
  final Task task;

  taskItem({required this.context, required this.index, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  task.description ?? "توضیحی هنوز وارد نشده است",
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
          ),
          Icon(
            Icons.delete,
            color: Colors.red[300],
            size: 20,
          )
        ],
      ),
    );
  }
}
