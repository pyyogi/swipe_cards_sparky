import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_connection_sparky/models/recommendation/recommendation_model.dart';
import 'package:test_connection_sparky/pages/recommendation_widget_model.dart';

class RecommendationWidget extends StatelessWidget {
  const RecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // List<Recommendation> recommendations =
    //     Provider.of<RecommendationWidgetModel>(context).recommendations;
    return Scaffold(
        body: FutureBuilder<Recommendation>(
      future: Provider.of<RecommendationWidgetModel>(context).showRecommend(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Recommendation recommendation = snapshot.data!;
          return Center(
            child: Text(recommendation.toString()),
          );
        }
      },
    ));
  }
}
