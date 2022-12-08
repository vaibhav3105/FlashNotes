import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFee7b64),
      width: 2,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFFee7b64),
      width: 2,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
      width: 2,
    ),
  ),
);

void nextScreen(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

void nextReplacementScreen(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
