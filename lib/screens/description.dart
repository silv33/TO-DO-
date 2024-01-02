import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newapp/home_screen.dart';

class Description extends StatelessWidget {
  final String title, description, uid, docs;
  const Description(HomeScreen widget,
      {super.key,
      required this.title,
      required this.description,
      required this.uid,
      required this.docs});

  @override
  Widget build(BuildContext context) {
    var titlecon = TextEditingController(text: title);
    var desccon = TextEditingController(text: description);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Description'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('tasks')
                    .doc(uid)
                    .collection('mytasks')
                    .doc(docs)
                    .update(
                        {'title': titlecon.text, 'description': desccon.text});
                Navigator.pop(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  controller: titlecon,
                  style: GoogleFonts.roboto(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                margin: const EdgeInsets.all(10),
                child: TextField(
                  maxLines: null,
                  expands: true,
                  controller: desccon,
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              )
            ],
          ),
        ));
  }
}
