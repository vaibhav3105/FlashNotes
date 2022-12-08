import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:my_notes/widgets/styling.dart';

class MyBottomSheet extends StatefulWidget {
  final String title;
  final String subject;
  MyBottomSheet({required this.subject, required this.title});
  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    subjectController.dispose();
  }

  final titleController = TextEditingController();

  final subjectController = TextEditingController();
  bool? preData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.title;
    subjectController.text = widget.subject;
    if (titleController.text.isNotEmpty) {
      preData = true;
    } else {
      preData = false;
    }
  }

  @override
  Future createNote(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            !preData! ? "Note added Successfully" : "Note updated Successfully",
            textAlign: TextAlign.center,
          ),
        ),
      );
      if (preData == false) {
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("notes")
            .add({
          "title": titleController.text,
          "subject": subjectController.text,
          "date": DateTime.now().toString()
        });
      } else {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection("notes")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("notes")
            .where("subject", isEqualTo: widget.subject)
            .get();
        String id = snapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection("notes")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("notes")
            .doc(id)
            .update({
          "title": titleController.text,
          "subject": subjectController.text,
          "date": DateTime.now().toString()
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20),
      children: [
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () => createNote(context),
          child: Container(
            padding: EdgeInsets.all(14),
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              !preData! ? "Add Note" : "Update Note",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Title",
                    prefixIcon: Icon(
                      Icons.title,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                  controller: subjectController,
                  maxLines: 10,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter subject";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Subject",
                    prefixIcon: Icon(
                      Icons.book,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
