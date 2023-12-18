import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:time_machine/time_machine.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 10)
class Recommendation extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool sex;

  @HiveField(3)
  int age;

  @HiveField(4)
  String imgPath;

  @HiveField(5)
  double latitude;

  @HiveField(6)
  double longitude;

  factory Recommendation.fromFormData(Map<String, dynamic> formData) {
    if (formData
        case {
          'id': int id,
          'name': String name,
          'sex': bool sex,
          'birthday': DateTime birthday,
          'latitude': double latitude,
          'longitude': double longitude,
          'img_path': String imgPath
        }) {
      birthday = birthday.toLocal();
      var birthdayLocalDate =
          LocalDate(birthday.year, birthday.month, birthday.day);
      var age = LocalDate.today().periodSince(birthdayLocalDate).years;
      return Recommendation(
          id: id,
          name: name,
          sex: sex,
          age: age,
          imgPath: imgPath,
          latitude: latitude,
          longitude: longitude);
    } else {
      throw const FormatException("Unexpected type of FormData");
    }
  }
  Recommendation({
    required this.id,
    required this.name,
    required this.sex,
    required this.age,
    required this.imgPath,
    required this.latitude,
    required this.longitude,
  });
  // factory Recommendation.fromJson(Map<String, dynamic>) =>

  @override
  String toString() {
    return 'Recommendation(id: $id, sex: $sex, name: $name, age: $age, imgPath: $imgPath, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Recommendation && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
