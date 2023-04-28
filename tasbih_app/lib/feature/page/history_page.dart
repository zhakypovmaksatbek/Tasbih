// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kartal/kartal.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tasbih_app/feature/constants/text_constants.dart';
import 'package:uuid/uuid.dart';

import '../../database/data/local_storage.dart';
import '../../database/models/zikr_model.dart';
import '../constants/box_decoration.dart';
import '../constants/color_constants.dart';
import '../getx/controller/getx_controller.dart';
import '../product/custom_icon_button.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  final GetXController controller = Get.put(GetXController());

  late List<ZikrModel> _allZikrs = [];
  late HiveLocalStorage _localStorage;
  @override
  void initState() {
    super.initState();

    _localStorage = HiveLocalStorage();
    _getAllZikrFromDb();
  }

  Future<void> _getAllZikrFromDb() async {
    _allZikrs = await _localStorage.getAllZikr();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        actions: [
          CustomIconButton(
            color: ColorConstants.green,
            icon: Icons.add,
            onTap: () async {
              _addNewUser(context);
            },
          )
        ],
        backgroundColor: Colors.transparent,
        surfaceTintColor: ColorConstants.backgroundColor,
        leading: CustomIconButton(
          color: ColorConstants.white,
          icon: Icons.arrow_back_ios_new_outlined,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          TextConstants.history,
          style: context.theme.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: ColorConstants.backgroundColor,
          color: ColorConstants.green,
          onRefresh: _getAllZikrFromDb,
          child: ListView.builder(
            itemCount: _allZikrs.length,
            itemBuilder: (BuildContext context, int index) {
              var selectedZikr = _allZikrs[index];

              return Padding(
                padding: context.paddingNormal,
                child: Container(
                  decoration: CustomBoxDecoration.customBoxDecoration,
                  child: Dismissible(
                    key: Key(selectedZikr.id),
                    onDismissed: (direction) {
                      if (index < _allZikrs.length) {
                        _allZikrs.removeAt(index);
                        _localStorage.deleteZikr(zikr: selectedZikr);
                      } else {
                        return;
                      }
                    },
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20.0),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          _allZikrs[index].zikrName,
                          style: context.theme.textTheme.headlineSmall
                              ?.copyWith(
                                  color: ColorConstants.green,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                      leading: Text(
                        _allZikrs[index].zikrCount.toString(),
                        style: context.theme.textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<dynamic> _addNewUser(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final zikrNameController = TextEditingController();

        return AlertDialog(
          title: const Text(TextConstants.addZikr),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: zikrNameController,
                decoration: const InputDecoration(
                  labelText: TextConstants.zikrName,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(TextConstants.cancel),
            ),
            TextButton(
              onPressed: () async {
                if (zikrNameController.text.length < 3) {
                  QuickAlert.show(
                      confirmBtnColor: ColorConstants.backgroundColor,
                      context: context,
                      type: QuickAlertType.error,
                      title: TextConstants.ooi,
                      text: TextConstants.sorry,
                      confirmBtnText: TextConstants.fixIt);
                } else {
                  final newZikr = ZikrModel(
                    zikrName: zikrNameController.text,
                    id: const Uuid().v1(),
                    createdAt: DateTime.now(),
                    zikrCount: 0,
                  );

                  Navigator.pop(context);

                  QuickAlert.show(
                      title: TextConstants.success,
                      confirmBtnColor: ColorConstants.backgroundColor,
                      context: context,
                      type: QuickAlertType.success,
                      text: TextConstants.addedSuccessfully,
                      confirmBtnText: TextConstants.okay);
                  await HiveLocalStorage().addZikr(zikr: newZikr);
                }
              },
              child: const Text(TextConstants.add),
            ),
          ],
        );
      },
    );
  }
}
