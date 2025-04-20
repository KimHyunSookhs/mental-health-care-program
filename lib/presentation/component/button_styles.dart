import 'package:flutter/material.dart';

abstract class ButtonStyles {
  static final ButtonStyle signInButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      side: BorderSide(color: Colors.black),
    ),
  );
}
