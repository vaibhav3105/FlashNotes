import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/widgets/drawer.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String userName = "";
  String email = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        userName = value["userName"];
      });
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        email = value["email"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Your Account",
        ),
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 110,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 90,
              child: Icon(
                Icons.person,
                size: 130,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: Icon(
                    Icons.person_outlined,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Name :",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Text(
                    userName,
                    style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Email :",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Container(
                    width: 100,
                    child: Text(
                      email,
                      style: TextStyle(fontSize: 17, color: Colors.grey[700]),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.blue,
                  ),
                  title: Text(
                    "Status :",
                    style: TextStyle(fontSize: 17),
                  ),
                  trailing: Container(
                    width: 115,
                    child: Row(
                      children: [
                        Text(
                          "Verified",
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey[700]),
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Icon(
                          Icons.verified,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
