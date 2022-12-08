import 'package:flutter/material.dart';
import 'package:my_notes/helper.dart';
import 'package:my_notes/screens/auth/login_screen.dart';
import 'package:my_notes/screens/intro_screens/intro_screen_1.dart';
import 'package:my_notes/screens/intro_screens/intro_screen_2.dart';
import 'package:my_notes/screens/intro_screens/intro_screen_3.dart';
import 'package:my_notes/widgets/styling.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Helper.saveUserIntroStatus(true);
  }

  bool onLastPage = false;
  PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: ((index) {
              setState(() {
                onLastPage = (index == 2);
              });
            }),
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                if (onLastPage)
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      nextReplacementScreen(context, LoginScreen());
                    },
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                if (!onLastPage)
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
