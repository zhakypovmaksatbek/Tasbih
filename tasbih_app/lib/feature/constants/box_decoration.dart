import 'package:flutter/material.dart';

class CustomBoxDecoration {
  static final BoxDecoration customBoxDecoration = BoxDecoration(
    border: Border.all(color: const Color(0xff333333)),
    color: const Color(0xff333333),
    borderRadius: BorderRadius.circular(50),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff333333),
        Color(0xff333333),
      ],
    ),
    boxShadow: const [
      BoxShadow(
        color: Color(0xff535353),
        offset: Offset(0.5, -0.5),
        blurRadius: 13,
        spreadRadius: 0.0,
      ),
      BoxShadow(
        color: Color(0xff131313),
        offset: Offset(-1.5, 1.5),
        blurRadius: 12,
        spreadRadius: 0.0,
      ),
    ],
  );
}
