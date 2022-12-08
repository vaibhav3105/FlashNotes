import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Get Started Now",
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Click on Get Started to Login or Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.grey[500], fontSize: 20, height: 1.4),
              ),
              SizedBox(
                height: 70,
              ),
              Lottie.network(
                  'https://assets4.lottiefiles.com/packages/lf20_ii6qdbgz.json',
                  height: 300,
                  width: 300),
            ],
          ),
        ),
      ),
    );
  }
}
