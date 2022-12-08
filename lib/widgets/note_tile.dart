import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'bottom_sheet.dart';
import 'dart:math' as math;

class NoteTile extends StatefulWidget {
  final String title;
  final String subject;
  final String time;

  const NoteTile({
    Key? key,
    required this.subject,
    required this.time,
    required this.title,
  }) : super(key: key);

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  Color? bgcolor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bgcolor =
        Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Color.fromARGB(255, 217, 240, 218),
                  context: context,
                  builder: (ctx) {
                    return MyBottomSheet(
                      title: widget.title,
                      subject: widget.subject,
                    );
                  });
            },
            child: Container(
              height: (MediaQuery.of(context).size.width - 30) / 2,
              width: (MediaQuery.of(context).size.width - 30) / 2,
              decoration: BoxDecoration(
                color: bgcolor,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.time.substring(0, widget.time.indexOf(" ") + 1),
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(widget.subject.length < 55
                      ? widget.subject
                      : widget.subject.substring(0, 54) + ".....")
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: ((MediaQuery.of(context).size.width - 30) / 2) - 45,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              print(MediaQuery.of(context).size.height);
              print(MediaQuery.of(context).size.width);
              showModalBottomSheet(
                  backgroundColor: Color.fromARGB(255, 217, 240, 218),
                  context: context,
                  builder: (ctx) {
                    return MyBottomSheet(
                      title: widget.title,
                      subject: widget.subject,
                    );
                  });
            },
            child: Lottie.network(
                "https://assets4.lottiefiles.com/private_files/lf30_ypgvza1p.json",
                width: 60,
                height: 60),
          ),
        ),
        Positioned(
          left: ((MediaQuery.of(context).size.width - 30) / 2) - 25,
          top: 0,
          child: GestureDetector(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    title: Text("Are you sure you want to delete this note?"),
                    icon: Lottie.network(
                        "https://assets4.lottiefiles.com/packages/lf20_d6r9tuqy.json",
                        height: 150,
                        width: 150),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Lottie.network(
                              "https://assets3.lottiefiles.com/packages/lf20_PLsXq6.json",
                              height: 100,
                              width: 100),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pop();
                            QuerySnapshot snapshot = await FirebaseFirestore
                                .instance
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
                                .delete();
                            // Navigator.of(context).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //       builder: (ctx) => HomeScreen(),
                            //     ),
                            //     (route) => false);
                          },
                          child: Lottie.network(
                              "https://assets4.lottiefiles.com/packages/lf20_bqurfq5c.json",
                              height: 100,
                              width: 100),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Lottie.network(
              "https://assets4.lottiefiles.com/packages/lf20_VmD8Sl.json",
              height: 40,
              width: 40,
            ),
          ),
        ),
      ],
    );
  }
}
