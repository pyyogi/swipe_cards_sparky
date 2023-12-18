import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

part 'recommendation_settings_model.g.dart';

@HiveType(typeId: 11)
class RecommendationSettings extends ChangeNotifier {
  RecommendationSettings(
      {this.currentIdx = 0, this.limit = 50, required this.realSize});

  @HiveField(0)
  int currentIdx;

  // @HiveField(1)
  // int startPart1 = 0;

  // @HiveField(2)
  // int endPart1;

  // @HiveField(3)
  // int startPart2 = 50;

  // @HiveField(4)
  // int endPart2;

  @HiveField(5)
  int limit;

  @HiveField(6)
  int realSize;

  @override
  String toString() {
    return 'RecommendationSettingsModel($currentIdx)';
  }
}
