import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_connection_sparky/boxes.dart';
import 'package:test_connection_sparky/models/recommendation/recommendation_model.dart';
import 'package:test_connection_sparky/models/recommendation_settings/recommendation_settings_model.dart';
import 'package:time_machine/time_machine.dart';

final dio = Dio();
var ipAddress = dotenv.env['IP_ADDRESS'];
Response? response;
final userId = 13;

class RecommendationWidgetModel extends ChangeNotifier {
  // late final Future<Box<Recommendation>> recommendBox;
  // late final Future<Box<RecommendationSettings>> recommendSettingsBox;
  var _recommendations = <Recommendation>[];

  List<Recommendation> get recommendations => _recommendations.toList();

  RecommendationWidgetModel() {
    _setUp();
  }
  void _setUp() async {
    if (!Hive.isAdapterRegistered(10)) {
      Hive.registerAdapter(RecommendationAdapter());
    }
    if (!Hive.isAdapterRegistered(11)) {
      Hive.registerAdapter(RecommendationSettingsAdapter());
    }
    // final recommendBox = await _recommendBox;
    // Hive.openBox<Recommendation>('recommendations');
    // final recommendSettingsBox = await _recommendSettingsBox;
    // recommendBox = Hive.openBox<Recommendation>('recommendations');
    // recommendSettingsBox =
    //     Hive.openBox<RecommendationSettings>('recommendSettings');
    // final recommendBox = await recommendBox;
    // final recommendSettingsBox = await recommendSettingsBox;
    // print(recommendSettingsBox.values);
    if (recommendSettingsBox.isEmpty) {
      await recommendSettingsBox.put(0, RecommendationSettings(realSize: 0));
    }
    await recommendSettingsBox.put(0, RecommendationSettings(realSize: 0));
    print(recommendSettingsBox.values);
    // if (!recommendBox.containsKey(0)) {
    //   recommendSettingsBox.putAt(0, RecommendationSettings(realSize: 0));
    // }

    // recommendations.add((await loadData(13, 1))[0]);
    notifyListeners();
  }

  int getCurrentIdx() {
    // final recommendSettingsBox = await recommendSettingsBox;
    RecommendationSettings? recommendationSettings =
        recommendSettingsBox.get(0);
    // print(recommendationSettings?.currentIdx ?? 0);
    // notifyListeners();
    return recommendationSettings?.currentIdx ?? 0;
  }

  int getIncreasedIdx() {
    RecommendationSettings? recommendationSettings =
        recommendSettingsBox.get(0);
    final currIdx = recommendationSettings?.increaseCurrentIdx() ?? 0;
    if (currIdx == 0) {
      loadRecommendationsInHive();
    }
    recommendSettingsBox.put(0, recommendationSettings);
    return currIdx;
    // notifyListeners();
  }

  // int getRecommendationIdx() {
  //   print(getCurrentIdx());
  //   Recommendation recommendation = recommendBox.get(getCurrentIdx() - 1);
  //   return recommendation.id;
  // }

  Future<Recommendation?> getRecommendation() async {
    // final recommendBox = await recommendBox;
    final currentIdx = await getCurrentIdx();
    Recommendation? recommendation = recommendBox.getAt(currentIdx);
    return recommendation;
  }

  void sendReaction(int userId, int toId, bool isLiked) async {
    final formDataRequest = FormData.fromMap({
      'user_id': userId,
      'to_id': toId,
      'like': isLiked,
    });

    response = await dio.post('http://$ipAddress:8080/reaction',
        data: formDataRequest);

    await loadRecommendationsInHive();
    getIncreasedIdx();

    notifyListeners();
  }

  Future<List<Recommendation>> loadRecommendationsInHive() async {
    RecommendationSettings? recommendationSettings =
        recommendSettingsBox.get(0);
    int currentIdx = getCurrentIdx();
    int? realSize = recommendationSettings?.realSize ?? 0;
    int? limit = recommendationSettings?.limit ?? 50;
    print('Limit $limit');
    List<Recommendation> recommendations = <Recommendation>[];
    if (currentIdx >= realSize || realSize == 0) {
      print('Вошел');
      recommendBox.clear();
      recommendations = await loadDataFromServer(userId, limit);
      print('recommendations: $recommendations');
      for (int i = 0; i < recommendations.length; i++) {
        recommendBox.put(i, recommendations[i]);
      }

      recommendSettingsBox.put(
          0, RecommendationSettings(realSize: recommendations.length));
      // notifyListeners();
    } else {
      print('Не вошел');
    }

    return recommendations;
  }

  Future<List<Recommendation>> loadDataFromServer(int userId, int limit) async {
    List<Recommendation> recommendations = [];
    try {
      final formDataRequest = FormData.fromMap({
        'user_id': userId,
        'sex': true,
        'distance': 1,
        'limit': 50,
        'min_age': 20,
        'max_age': 3000,
      });
      response = await dio.post('http://$ipAddress:8080/recommendations',
          data: formDataRequest);
      // print(response?.data);
      List<dynamic> data = jsonDecode(response?.data);
      List<Recommendation> recommendations = data
          .map((recommendation) => Recommendation(
              id: recommendation['id'],
              name: recommendation['name'],
              sex: recommendation['sex'],
              age: LocalDate.today()
                  .periodSince(LocalDate(
                      DateTime.parse(recommendation['birthday']).toLocal().year,
                      DateTime.parse(recommendation['birthday'])
                          .toLocal()
                          .month,
                      DateTime.parse(recommendation['birthday']).toLocal().day))
                  .years,
              // (DateTime.now().difference(DateTime.parse(recommendation['birthday']))),
              // recommendation['birthday'],
              latitude: recommendation['latitude'].toDouble(),
              longitude: recommendation['longitude'].toDouble(),
              imgPath: recommendation['img_path']))
          .toList();
      // print(recommendations[0]);
      // boxUser.deleteAll(boxUser.keys);
      // boxUser.put(0, User(id: int.parse(response.data)));

      return recommendations;
    } on DioException catch (e) {
      print(e.response!.statusCode!);
      return recommendations;
    }
  }

  Future<List<Recommendation>> showRecommends() async {
    RecommendationSettings? recommendationSettings =
        recommendSettingsBox.get(0);
    int currentIdx = getCurrentIdx();
    int limit = recommendationSettings?.limit ?? 50;
    int realSize = recommendationSettings?.realSize ?? 0;
    print('realSize: $realSize');
    print('currentIdx: $currentIdx');

    await loadRecommendationsInHive();

    return recommendBox.values.toList() as List<Recommendation>;
  }

  Future<Recommendation> showRecommend() async {
    // final recommendBox = await recommendBox;
    // final recommendSettingsBox = await recommendSettingsBox;

    RecommendationSettings? recommendationSettings =
        recommendSettingsBox.get(0);
    int currentIdx = getCurrentIdx();
    // int startPart1 = recommendationSettings?.startPart1 ?? 0;
    // int endPart1 = recommendationSettings?.endPart1 ?? 49;
    // int startPart2 = recommendationSettings?.startPart2 ?? 50;
    // int endPart2 = recommendationSettings?.endPart2 ?? 99;
    int limit = recommendationSettings?.limit ?? 50;
    int realSize = recommendationSettings?.realSize ?? 0;
    print('realSize: $realSize');
    print('currentIdx: $currentIdx');

    // if (currentIdx >= realSize || realSize == 0) {
    //   print('Вошел');
    //   recommendBox.clear();
    //   List<Recommendation> recommendations = await loadData(userId, limit);
    //   print('recommendations: $recommendations');
    //   for (int i = 0; i < recommendations.length; i++) {
    //     recommendBox.put(i, recommendations[i]);
    //   }
    // } else {
    //   print('Не вошел');
    // }
    // realSize = recommendations.length;
    // recommendSettingsBox.put(0,
    //     RecommendationSettings(currentIdx: currentIdx + 1, realSize: realSize));
    await loadRecommendationsInHive();

    Recommendation? recommendation = recommendBox.get(currentIdx);
    if (recommendation == null) {
      recommendation = recommendBox.get(0);
    }
    if (recommendation == null) {
      throw Exception('No recommendations found');
    }
    return recommendation;
    // return recommendBox.values.toList() as List<Recommendation>;

    // return recommendBox.get(currentIdx - 1) ?? recommendBox.get(0);
    // if (startPart1 <= currentIdx && currentIdx <= endPart1 ||
    //     startPart2 <= currentIdx && currentIdx <= endPart2) {
    //   Recommendation? recommendation =
    //       recommendBox.getAt(recommendationSettings?.currentIdx ?? 0);
    // recommendSettingsBox.putAt(
    //     0,
    //     RecommendationSettings(
    //         endPart1: endPart1,
    //         endPart2: endPart2,
    //         currentIdx: currentIdx + 1));
    // } else {
    //   if (currentIdx > endPart2) {
    //     currentIdx = startPart1;
    //     final recomendList = await loadData(userId, 2);
    //     for (int i = startPart2;
    //         i < (recomendList.length + startPart2);
    //         i += 1) {
    //       recommendBox.putAt(i, recomendList[i]);
    //     }
    //   } else if (currentIdx > endPart1) {
    //     currentIdx = startPart2;
    //   }
    // }

    // if (endPart1 <= currentIdx && currentIdx <= startPart2) {}
  }
}
