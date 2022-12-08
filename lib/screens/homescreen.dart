import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/widgets/bottom_sheet.dart';
import 'package:my_notes/widgets/drawer.dart';
import 'package:my_notes/widgets/note_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? userName = "";

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        setState(() {
          userName = value['userName'];
        });
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Image.asset(
              "assets/splash.png",
              height: 30,
              width: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "FlashNotes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        icon: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              backgroundColor: Color.fromARGB(255, 217, 240, 218),
              context: context,
              builder: (ctx) {
                return MyBottomSheet(
                  subject: "",
                  title: "",
                );
              });
        },
        label: Text("Add Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("notes")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("notes")
              .orderBy("date", descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data.docs.length > 0) {
              return GridView.builder(
                  itemCount: snapshot.data.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return NoteTile(
                      key: ValueKey(snapshot.data.docs[index]['subject']),
                      title: snapshot.data.docs[index]["title"],
                      subject: snapshot.data.docs[index]['subject'],
                      time: snapshot.data.docs[index]['date'],
                    );
                  });
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Text(
                        "Hey! You don't have any notes. Tap on the + button to add a note.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey[700], fontSize: 25, height: 1.5),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 5,
                      ),
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor:
                                    Color.fromARGB(255, 217, 240, 218),
                                context: context,
                                builder: (ctx) {
                                  return MyBottomSheet(
                                    subject: "",
                                    title: "",
                                  );
                                });
                          },
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.black,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 150,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
