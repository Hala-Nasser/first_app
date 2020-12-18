import 'package:flutter_todo_task/db_helper.dart';

class Task {
  String taskName;
  bool isComplete;
  Task({this.taskName, this.isComplete});

  toJson() {
    return {
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskIsCompleteName: this.isComplete ? 1 : 0
    };
  }
}
