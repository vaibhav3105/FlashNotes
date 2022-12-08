import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Introducing FlashNotes",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Your Ultimate Notes Planner",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 20),
              ),
              SizedBox(
                height: 70,
              ),
              Lottie.network(
                  'https://assets3.lottiefiles.com/private_files/lf30_s2njkgde.json',
                  height: 300,
                  width: 300),
            ],
          ),
        ),
      ),
    );
  }
}
