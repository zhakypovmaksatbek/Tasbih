// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../getx/controller/getx_controller.dart';

class MyListWheelScrollView extends GetView {
  MyListWheelScrollView(
      {super.key,
      required this.controller,
      required this.zikrCount,
      required this.zikr});

  @override
  final FixedExtentScrollController controller;
  final RxInt zikrCount;
  final zikr;
  final GetXController getXController = Get.put(GetXController());

  DateTime? lastUpdateTime;
  final Duration minimumDuration = const Duration(seconds: 2);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        controller.addListener(() {
          if (!controller.position.atEdge) {
            if (lastUpdateTime == null ||
                DateTime.now().difference(lastUpdateTime!) > minimumDuration) {
              lastUpdateTime = DateTime.now();
            }
          }
        });
        if (notification is ScrollEndNotification) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            return true;
          });
        }
        return false;
      },
      child: ListWheelScrollView.useDelegate(
        scrollBehavior:ScrollConfiguration.of(context).copyWith(
          
        ),
        controller: controller,
        physics: const FixedExtentScrollPhysics(),
        perspective: 0.006,
        diameterRatio: 1.8,
        itemExtent: 220,
        squeeze: 0.8,
        offAxisFraction: -0.0,
        onSelectedItemChanged: (value) {
          getXController.itemCount.value = value;
          getXController.incrementZikirCount(value);
          zikrCount.value = value;
          Vibration.vibrate(duration: 50);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 1000,
          builder: (context, index) {
            return Container(
                width: 100,
                //height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xff333333),
                  borderRadius: BorderRadius.circular(74),
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
                      color: Color(0xff4f4f4f),
                      offset: Offset(-14.3, 14.3),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color(0xff171717),
                      offset: Offset(14.3, -14.3),
                      blurRadius: 40,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: context.textTheme.headlineLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
