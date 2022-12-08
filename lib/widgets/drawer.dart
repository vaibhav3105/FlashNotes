import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_notes/helper.dart';
import 'package:my_notes/screens/account_screen.dart';
import 'package:my_notes/screens/auth/login_screen.dart';
import 'package:my_notes/screens/homescreen.dart';
import 'package:my_notes/widgets/styling.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: 250,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset(
              "assets/splash.png",
              height: 100,
              width: 100,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                nextReplacementScreen(context, HomeScreen());
              },
              child: Container(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.home),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Your Notes"),
                  ],
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                nextReplacementScreen(context, AccountScreen());
              },
              child: Container(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Your Account"),
                  ],
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Are you sure you want to Logout?"),
                      icon: Lottie.network(
                          "https://assets6.lottiefiles.com/packages/lf20_vmlm0zew.json",
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
                              await FirebaseAuth.instance.signOut();
                              await Helper.saveUserLoggedInStatus(false);
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (ctx) => LoginScreen(),
                                  ),
                                  (route) => false);
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
              child: Container(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Log Out"),
                  ],
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.3,
            ),
            Text(
              "Created by Vaibhav Jain",
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Copyright @ 2022-23. All Rights Reserved.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            )
          ],
        ),
      ),
    );
  }
}
