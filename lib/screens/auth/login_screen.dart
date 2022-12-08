import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_notes/helper.dart';
import 'package:my_notes/screens/auth/register_screen.dart';
import 'package:my_notes/screens/auth/verify_email_screen.dart';
import 'package:my_notes/widgets/styling.dart';

import 'forgot_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? email = "";
  String? password = "";
  bool isLoading = false;
  @override
  Future login(String email, String password) async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        await Helper.saveUserLoggedInStatus(true);

        nextReplacementScreen(context, VerifyEmailScreen());
      } on FirebaseAuthException catch (error) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error.message!,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "FlashNotes",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Login now to access or create new notes.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                ),
                // Image.asset("assets/login.png"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
                  child: Lottie.network(
                      "https://assets3.lottiefiles.com/packages/lf20_hzgq1iov.json",
                      height: 200,
                      width: 200),
                ),
                TextFormField(
                  onChanged: (newValue) {
                    email = newValue;
                  },
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val!)
                        ? null
                        : "Please enter a valid email";
                  },
                  decoration: textInputDecoration.copyWith(
                    labelText: "Email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (newValue) {
                    password = newValue;
                  },
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Password have atleast 6 characters";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                    labelText: "Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    nextScreen(context, ForgotScreen());
                    // try {
                    //   await FirebaseAuth.instance
                    //       .sendPasswordResetEmail(email: emailController.text);
                    // } on FirebaseAuthException catch (error) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(
                    //         error.message!,
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       backgroundColor: Theme.of(context).errorColor,
                    //     ),
                    //   );
                    // }
                  },
                  child: Text(
                    "Forgot Password??",
                    style: TextStyle(
                        decoration: TextDecoration.underline, fontSize: 12),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () {
                      login(email!.trim(), password!.trim());
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        nextReplacementScreen(context, RegisterScreen());
                      },
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                if (isLoading)
                  CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
