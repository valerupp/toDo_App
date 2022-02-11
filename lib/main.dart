import 'package:flutter/material.dart';
import 'new_tasks.dart';
import 'if_of_todo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amberAccent
        
      ),
      home: const SafeArea(
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final noticesHeight = 640.toDouble();
  final List<Tasks> listOfTasks = [
    Tasks(
      title: "Schatz küssen",
      date: "19:00 Uhr",
    ),
    Tasks(
      title: "Auto sauber machen",
      date: "23.04.22",
    ),
  ];

  void addNewTask(String title, String date) {
    final newTsk = Tasks(
      title: title,
      date: date,
    );

    setState(() {
      listOfTasks.add(newTsk);
    });
  }

  void startAddNewTask(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTask(addNewTask);
        });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        title: const Text(
          "toDo App",
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            height: noticesHeight,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Aufgaben:",
                  textScaleFactor: 2.5,
                  style: TextStyle(
                      fontFamily: "ZenKurenaido",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: noticesHeight-71,
                child: ListView.builder(
                  itemCount: listOfTasks.length,
                  itemBuilder: (ctx, index) {
                    return CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: IconButton(
                        onPressed: () => setState(
                            () => listOfTasks.remove(listOfTasks[index])),
                        icon: const Icon(Icons.delete),
                      ),
                      activeColor: Colors.black54,
                      checkColor: Theme.of(context).accentColor,
                      onChanged: (value) => setState(() =>
                          listOfTasks[index].done = !listOfTasks[index].done),
                      value: listOfTasks[index].done,
                      subtitle: Text(listOfTasks[index].date),
                      title: Text(
                        listOfTasks[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "ZenKurenaido",
                        ),
                        textScaleFactor: 1.5,
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: "Neue Aufgabe hinzufügen",
        backgroundColor: Theme.of(context).primaryColorLight,
        foregroundColor: Colors.black,
        onPressed: () => startAddNewTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
