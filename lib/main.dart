import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_notes/helper.dart';
import 'package:my_notes/screens/auth/login_screen.dart';
import 'package:my_notes/screens/auth/verify_email_screen.dart';
import 'package:my_notes/screens/intro_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  bool _hasSeenIntro = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserLoggedInAndIntroStatus();
  }

  Future getUserLoggedInAndIntroStatus() async {
    await Helper.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
    await Helper.getUserIntroStatus().then((value) {
      if (value != null) {
        setState(() {
          _hasSeenIntro = value;
        });
        print(_hasSeenIntro);
      }
    });
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFee7b64),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: (_isSignedIn == true && _hasSeenIntro == true)
          ? VerifyEmailScreen()
          : (_hasSeenIntro == true && _isSignedIn == false)
              ? LoginScreen()
              : IntroScreen(),
      // StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return HomeScreen();
      //     } else {
      //       return LoginScreen();
      //     }
      //   },
      // ),
    );
    //     StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //     if (snapshot.hasError) {
    //       return Center(
    //         child: Text("Error"),
    //       );
    //     }
    //     if (snapshot.hasData) {
    //       return VerifyEmailScreen();
    //     }
    //     return LoginScreen();
    //   },
  }
}
