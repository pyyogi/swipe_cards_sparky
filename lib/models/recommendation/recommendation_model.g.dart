// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecommendationAdapter extends TypeAdapter<Recommendation> {
  @override
  final int typeId = 10;

  @override
  Recommendation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recommendation(
      id: fields[0] as int,
      name: fields[1] as String,
      sex: fields[2] as bool,
      age: fields[3] as int,
      imgPath: fields[4] as String,
      latitude: fields[5] as double,
      longitude: fields[6] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Recommendation obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sex)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.imgPath)
      ..writeByte(5)
      ..write(obj.latitude)
      ..writeByte(6)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecommendationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) =>
    Recommendation(
      id: json['id'] as int,
      name: json['name'] as String,
      sex: json['sex'] as bool,
      age: json['age'] as int,
      imgPath: json['imgPath'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sex': instance.sex,
      'age': instance.age,
      'imgPath': instance.imgPath,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
