import 'package:hive_flutter/adapters.dart';

import '../models/zikr_model.dart';

abstract class LocalStorage {
  Future<void> addZikr({required ZikrModel zikr});
  Future<ZikrModel?> getZikr({required String id});
  Future<List<ZikrModel>> getAllZikr();
  Future<ZikrModel> updateZikr({required ZikrModel zikr});
  Future<bool> deleteZikr({required ZikrModel zikr});
}

class HiveLocalStorage extends LocalStorage {
  late Box<ZikrModel> _zikrBox;
  HiveLocalStorage() {
    _zikrBox = Hive.box('zikrs');
  }

  @override
  Future<void> addZikr({required ZikrModel zikr}) async {
    await _zikrBox.put(zikr.id, zikr);
  }

  @override
  Future<bool> deleteZikr({required ZikrModel zikr}) async {
    await zikr.delete();
    return true;
  }

  @override
  Future<List<ZikrModel>> getAllZikr() async {
    List<ZikrModel> allZikr = <ZikrModel>[];
    allZikr = _zikrBox.values.toList();
    if (allZikr.isNotEmpty) {
      allZikr.sort(
          (ZikrModel a, ZikrModel b) => b.createdAt.compareTo(a.createdAt));
    }
    return allZikr;
  }

  @override
  Future<ZikrModel?> getZikr({required String id}) async {
    if (_zikrBox.containsKey(id)) {
      return _zikrBox.get(id);
    } else {
      return null;
    }
  }

  @override
  Future<ZikrModel> updateZikr({required ZikrModel zikr}) async {
    await zikr.save();
    return zikr;
  }
}
