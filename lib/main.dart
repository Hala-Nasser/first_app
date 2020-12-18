import 'package:flutter/material.dart';
import 'package:flutter_todo_task/db_helper.dart';
import 'package:flutter_todo_task/new_task.dart';
import 'package:flutter_todo_task/task_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarPage(),
    );
  }
}

class TabBarPage extends StatefulWidget {
  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  PageController _pageController;
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text('Todo'),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              child: Container(
                child: Text(
                  'All Tasks',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Tab(
              child: Container(
                width: 100,
                margin: EdgeInsets.only(left: 10),
                child: Text('Complete Tasks', style: TextStyle(fontSize: 16)),
              ),
            ),
            Tab(
              child: Container(
                width: 100,
                child: Text(
                    'InComplete '
                    'Tasks',
                    style: TextStyle(fontSize: 16)),
              ),
            )
          ],
          isScrollable: true,
        ),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  AllTasks(),
                  CompleteTasks(),
                  InCompleteTasks()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return NewTask();
            },
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  Widget allTaskWidget() {
    return FutureBuilder(
      future: DBHelper.dbHelper.selectAllTasks(),
      builder: (context, projectSnap) {
        if (projectSnap.hasData) {
          return ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              bool isComplete = false;
              if (projectSnap.data[index].row[2] == 1) {
                isComplete = true;
              } else {
                isComplete = false;
              }
              return Card(
                  child: Padding(
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              content: Text(
                                  "You will Delete A task, are you sure?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                              actions: [
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Task task = Task(
                                        taskName:
                                            projectSnap.data[index].row[1],
                                        isComplete: isComplete);
                                    DBHelper.dbHelper.deleteTask(task);
                                    setState(() {});
                                    Navigator.pop(context);
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
                    Text(projectSnap.data[index].row[1],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    Checkbox(
                        value: isComplete,
                        onChanged: (value) {
                          Task task = Task(
                              taskName: projectSnap.data[index].row[1],
                              isComplete: !isComplete);
                          DBHelper.dbHelper.updateTask(task);
                          setState(() {});
                        })
                  ],
                ),
              ));
            },
          );
        }
        return Center();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return allTaskWidget();
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  Widget completeTaskWidget() {
    return FutureBuilder(
      future: DBHelper.dbHelper.selectCompleteTask(),
      builder: (context, projectSnap) {
        if (projectSnap.hasData) {
          return ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              bool isComplete = false;
              if (projectSnap.data[index].row[2] == 1) {
                isComplete = true;
              } else {
                isComplete = false;
              }
              return Card(
                  child: Padding(
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              content: Text(
                                  "You will Delete A task, are you sure?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                              actions: [
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Task task = Task(
                                        taskName:
                                            projectSnap.data[index].row[1],
                                        isComplete: isComplete);
                                    DBHelper.dbHelper.deleteTask(task);
                                    setState(() {});
                                    Navigator.pop(context);
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
                    Text(projectSnap.data[index].row[1],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    Checkbox(
                        value: isComplete,
                        onChanged: (value) {
                          Task task = Task(
                              taskName: projectSnap.data[index].row[1],
                              isComplete: !isComplete);
                          DBHelper.dbHelper.updateTask(task);
                          setState(() {});
                        })
                  ],
                ),
              ));
            },
          );
        }
        return Center();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return completeTaskWidget();
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  Widget inCompleteTaskWidget() {
    return FutureBuilder(
      future: DBHelper.dbHelper.selectInCompleteTask(),
      builder: (context, projectSnap) {
        if (projectSnap.hasData) {
          return ListView.builder(
            itemCount: projectSnap.data.length,
            itemBuilder: (context, index) {
              bool isComplete = false;
              if (projectSnap.data[index].row[2] == 1) {
                isComplete = true;
              } else {
                isComplete = false;
              }
              return Card(
                  child: Padding(
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
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              content: Text(
                                  "You will Delete A task, are you sure?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                              actions: [
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Task task = Task(
                                        taskName:
                                            projectSnap.data[index].row[1],
                                        isComplete: isComplete);
                                    DBHelper.dbHelper.deleteTask(task);
                                    setState(() {});
                                    Navigator.pop(context);
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
                    Text(projectSnap.data[index].row[1],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    Checkbox(
                        value: isComplete,
                        onChanged: (value) {
                          Task task = Task(
                              taskName: projectSnap.data[index].row[1],
                              isComplete: !isComplete);
                          DBHelper.dbHelper.updateTask(task);
                          setState(() {});
                        })
                  ],
                ),
              ));
            },
          );
        }
        return Center();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return inCompleteTaskWidget();
  }
}
