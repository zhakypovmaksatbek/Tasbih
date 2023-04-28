// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part 'zikr_model.g.dart';

@HiveType(typeId: 1)
class ZikrModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String zikrName;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final int zikrCount;

  ZikrModel({
    required this.id,
    required this.zikrName,
    required this.zikrCount,
    required this.createdAt,
  });
  factory ZikrModel.create({
    required String zikrName,
  }) {
    return ZikrModel(
        id: const Uuid().v1(),
        zikrName: zikrName,
        zikrCount: 0,
        createdAt: DateTime.now());
  }
}
