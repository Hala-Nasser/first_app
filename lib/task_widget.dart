import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_task/task_model.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  Function function;
  TaskWidget(this.task, [this.function]);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                showAlertDialog(BuildContext context) {
                  AlertDialog alert = AlertDialog(
                    title: Text(
                      "Alert",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    content: Text("You will Delete A task, are you sure?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 18)),
                    actions: [
                      FlatButton(
                        child: Text('Ok'),
                        onPressed: () {
                          // Task task = Task(
                          //     taskName: this.widget.task.taskName,
                          //     isComplete: this.widget.task.isComplete);
                          // DBHelper.dbHelper.deleteTask(task);
                          // setState(() {});
                          // Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }

                showAlertDialog(context);
              }),
          Text(widget.task.taskName,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
          Checkbox(
              value: widget.task.isComplete,
              onChanged: (value) {
                Task task = Task(
                    taskName: this.widget.task.taskName,
                    isComplete: !this.widget.task.isComplete);
                DBHelper.dbHelper.updateTask(task);
                setState(() {});
                widget.function();
              })
        ],
      ),
    );
  }
}
