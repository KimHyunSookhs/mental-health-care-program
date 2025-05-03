import 'package:flutter/material.dart';
import 'package:mental_health_care/core/ui/color_style.dart';

abstract class ButtonStyles {
  static final ButtonStyle unSelectedButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      side: BorderSide(color: ColorStyle.darkerGrey),
    ),
  );
  static final ButtonStyle selectedButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(24)),
      side: BorderSide(color: ColorStyle.darkerGrey),
    ),
  );
  static final ButtonStyle signInButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      side: BorderSide(color: Colors.black),
    ),
  );
}
