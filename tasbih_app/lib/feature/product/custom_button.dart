// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: context.verticalPaddingNormal,
        child: Container(
          // padding: context.verticalPaddingNormal,
          width: 50,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(color: ColorConstants.green),
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
                color: Color(0xff656565),
                offset: Offset(-8, 8),
                blurRadius: 13,
                spreadRadius: 0.0,
              ),
              BoxShadow(
                color: Color(0xff010101),
                offset: Offset(8, -8),
                blurRadius: 16,
                spreadRadius: 0.0,
              ),
            ],
          ),

          child: Icon(
            icon,
            color: ColorConstants.green,
          ),
        ),
      ),
    );
  }
}
