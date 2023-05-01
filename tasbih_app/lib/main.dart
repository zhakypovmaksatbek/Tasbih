import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:tasbih_app/feature/getx/controller/getx_controller.dart';
import 'package:tasbih_app/feature/page/screen_page.dart';

import 'database/data/local_storage.dart';
import 'database/models/zikr_model.dart';

final locator = GetIt.instance;
void setup() {
  locator.registerSingleton<LocalStorage>(HiveLocalStorage());
}

final List<ZikrModel> defaultZikrs = [
  ZikrModel(
      id: '1',
      zikrName: 'Alhamdulillah',
      zikrCount: 0,
      createdAt: DateTime.now()),
  ZikrModel(
      id: '2',
      zikrName: 'Subhanallah',
      zikrCount: 0,
      createdAt: DateTime.now()),
  ZikrModel(
      id: '3',
      zikrName: 'Allahu Akbar',
      zikrCount: 0,
      createdAt: DateTime.now()),
];

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ZikrModelAdapter());
  var zikrBox = await Hive.openBox<ZikrModel>('zikrs');
  if (zikrBox.isEmpty) {
    zikrBox.addAll(defaultZikrs);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData.dark(useMaterial3: true),
      home: const ScreenPage(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => GetXController());
      }),
    );
  }
}
