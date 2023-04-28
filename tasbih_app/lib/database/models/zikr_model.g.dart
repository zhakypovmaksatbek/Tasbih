// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zikr_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ZikrModelAdapter extends TypeAdapter<ZikrModel> {
  @override
  final int typeId = 1;

  @override
  ZikrModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ZikrModel(
      id: fields[0] as String,
      zikrName: fields[1] as String,
      zikrCount: fields[3] as int,
      createdAt: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ZikrModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.zikrName)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.zikrCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ZikrModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
