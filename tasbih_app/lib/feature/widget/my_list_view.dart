// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart' as kartal;
import 'package:tasbih_app/database/data/local_storage.dart';
import 'package:tasbih_app/database/models/zikr_model.dart';
import 'package:tasbih_app/main.dart';

import '../constants/box_decoration.dart';
import '../constants/color_constants.dart';
import '../getx/controller/getx_controller.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key, required this.itemTasbihatLengh});
  final int itemTasbihatLengh;

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final GetXController getXController = Get.put(GetXController());

  late List<ZikrModel> _allZikrs;
  late LocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    _localStorage = locator<LocalStorage>();
    _allZikrs = <ZikrModel>[];
    _getAllZikrFromDb();
  }

  Future<void> _getAllZikrFromDb() async {
    _allZikrs = await _localStorage.getAllZikr();
    setState(() {});
  }

  String selectedItem = '';
  void setSelectedItem(String item) {
    selectedItem = item;
  }

  void _onTap(int index) {
    setSelectedItem(_allZikrs[index].zikrName);
    setState(() {});
    getXController.scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              //physics: const FixedExtentScrollPhysics(),

              itemExtent: 180,
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemTasbihatLengh,

              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    _onTap(index);
                  },
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    transformAlignment: Alignment.center,
                    child: Padding(
                      padding: context.paddingNormal,
                      child: Container(
                        // width: 160,
                        // height: 160,
                        decoration: CustomBoxDecoration.customBoxDecoration,
                        child: Center(
                          child: Text(_allZikrs[index].zikrName,
                              style: const TextStyle(
                                color: ColorConstants.green,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: Text(selectedItem,
                style: context.theme.textTheme.headlineMedium?.copyWith(
                    color: ColorConstants.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
