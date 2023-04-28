// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Container(

            //padding: context.horizontalPaddingNormal,
            decoration: BoxDecoration(
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
            ),
            child: Center(
                child: Icon(
              icon,
              size: 30,
              color: color,
            ))));
  }
}
