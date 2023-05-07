import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../database/data/local_storage.dart';
import '../../database/models/zikr_model.dart';
import '../constants/color_constants.dart';
import '../getx/controller/getx_controller.dart';
import '../product/custom_button.dart';
import '../widget/my_list_view.dart';
import '../widget/my_listwheel_scroll_view.dart';
import '../widget/selected_zikr_text.dart';
import 'history_page.dart';

// HomePage sayfasini deneme olarak kodluyorum
class DemoPage extends StatefulWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  State<DemoPage> createState() => _HomePageState();
}

class _HomePageState extends State<DemoPage> {
  final GetXController controller = Get.put(GetXController());

  final selectedTitleZikr = SelectedTitleZikr();

  void restartCount() {
    controller.scrollController.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOutSine);
  }

  late List<ZikrModel> _allZikrs = [];

  late HiveLocalStorage _localStorage;

  @override
  void initState() {
    super.initState();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    _localStorage = HiveLocalStorage();
    _getAllZikrFromDb();
  }

  Future<void> _getAllZikrFromDb() async {
    _allZikrs = await _localStorage.getAllZikr();
    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Obx(() => Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyListView(
                    itemTasbihatLengh: _allZikrs.length,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          // CustomButton(icon: Icons.save_alt_outlined),
                          CustomButton(
                            icon: Icons.history_outlined,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HistoryPage(),
                                  ));
                            },
                          ),

                          CustomButton(
                            icon: Icons.restart_alt_outlined,
                            onTap: () {
                              restartCount();
                            },
                          ),
                          CustomButton(
                            icon: Icons.save_alt_outlined,
                            onTap: () {},
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                            height: 500,
                            child: MyListWheelScrollView(
                              zikr: selectedTitleZikr,
                              zikrCount: controller.itemCount.value.obs,
                              controller: controller.scrollController,
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
