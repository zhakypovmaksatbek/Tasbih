import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../database/data/local_storage.dart';
import '../../../database/models/zikr_model.dart';
import '../../../main.dart';

class GetXController extends GetxController {
  final FixedExtentScrollController controller = FixedExtentScrollController();
  //BU ListweelScrollview deki eleman sayisi
  final Rx<int> itemCount = 20.obs;

  late List<ZikrModel> _allZikrs;
  late LocalStorage _localStorage;

  RxInt zikrCount = RxInt(1);

  void setZikrCount(int value) {
    zikrCount.value = value;
  }

  List<ZikrModel> get allZikrs => _allZikrs;

  @override
  void onInit() {
    super.onInit();
    _localStorage = locator<LocalStorage>();
    _allZikrs = <ZikrModel>[];
    loadAllZikrs();
  }

  void loadAllZikrs() async {
    final allZikrs = await _localStorage.getAllZikr();
    _allZikrs = allZikrs;
    update();
  }

  void checkRestart() {
    controller.animateTo(
      0,
      duration: const Duration(microseconds: 1000),
      curve: Curves.bounceInOut,
    );
  }
}
