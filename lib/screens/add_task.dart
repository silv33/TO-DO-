import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:newapp/home_screen.dart';
import 'package:newapp/models/date_picker_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final duedateController = TextEditingController();
  Future<void> _selectDate() async {
    DateTime? picked = await DatePicker().selectDate(DateTime.now(), context);
    if (picked != null) {
      setState(() {
        duedateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  addtasktofirebase() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid;
    var time = DateTime.now();
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(time.toString())
        .set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'duedate': duedateController.text,
      'complete': false
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  @override
  Widget build(BuildContext context) {
    final duedateField = TextFormField(
      autofocus: false,
      controller: duedateController,
      keyboardType: TextInputType.datetime,
      onSaved: (value) {
        duedateController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'Due Date',
        filled: true,
        prefixIcon: const Icon(Icons.calendar_today), //Icon
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      readOnly: true,
      onTap: () {
        _selectDate();
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Enter Title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  labelText: 'Enter Description', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Container(
              child: duedateField,
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.purple.shade100;
                    }
                    return Theme.of(context).primaryColor;
                  }),
                ),
                child: const Text(
                  'add task',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  if (titleController.text != "") {
                    addtasktofirebase().then((uid) => {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen())),
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
