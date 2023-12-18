// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecommendationSettingsAdapter
    extends TypeAdapter<RecommendationSettings> {
  @override
  final int typeId = 11;

  @override
  RecommendationSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecommendationSettings(
      currentIdx: fields[0] as int,
      realSize: fields[6] as int,
    )..limit = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, RecommendationSettings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currentIdx)
      ..writeByte(5)
      ..write(obj.limit)
      ..writeByte(6)
      ..write(obj.realSize);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecommendationSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
