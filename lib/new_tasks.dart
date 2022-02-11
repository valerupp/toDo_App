import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  final Function addTask;

  const NewTask(this.addTask, {Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleController = TextEditingController();

  final dateController = TextEditingController();

  void addingTask() {
    final enteredTitle = titleController.text;
    final enteredDate = dateController.text;

    if (enteredTitle.isEmpty || enteredDate.isEmpty) {
      return;
    }

    widget.addTask(
      enteredTitle,
      enteredDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              onSubmitted: (_) => addingTask(),
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titel",
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addingTask(),
              controller: dateController,
              decoration: const InputDecoration(
                labelText: "Deadline",
              ),
            ),
            SizedBox(
              height: 40,
              child: TextButton(
                  onPressed: addingTask,
                  child: const Text("Hinzufügen"),
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
