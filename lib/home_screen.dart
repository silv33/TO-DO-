import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newapp/screens/add_task.dart';
import 'package:newapp/screens/description.dart';
import 'package:newapp/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = '';
  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    uid = auth.currentUser!.uid;

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      throw UnimplementedError();
    }
  }

  var checkBoxIcon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("TO DO"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color.fromARGB(255, 187, 149, 204),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('tasks')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              final docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: docs?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    widget,
                                    title: docs?[index]['title'],
                                    description: docs?[index]['description'],
                                    uid: uid,
                                    docs: docs?[index]['time'],
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: IconButton(
                                  icon: Icon((docs?[index]['complete'])
                                      ? Icons.check_box
                                      : Icons
                                          .check_box_outline_blank), //checkbox
                                  color: Colors.white,
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(uid)
                                        .collection('mytasks')
                                        .doc(docs?[index]['time'])
                                        .update({
                                      'complete': (!docs?[index]['complete'])
                                    });
                                  })),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text(
                                      docs?[index]['title'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )),
                              ]),
                          Container(
                              child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('tasks')
                                        .doc(uid)
                                        .collection('mytasks')
                                        .doc(docs?[index]['time'])
                                        .delete();
                                  }))
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
