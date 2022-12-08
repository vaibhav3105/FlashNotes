import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Notes Creation Made Easy",
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Access your notes anytime from anywhere",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 20),
              ),
              SizedBox(
                height: 70,
              ),
              Lottie.network(
                  'https://assets7.lottiefiles.com/packages/lf20_ttvteyvs.json',
                  height: 300,
                  width: 300),
            ],
          ),
        ),
      ),
    );
  }
}
