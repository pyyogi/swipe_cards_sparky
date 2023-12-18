import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:provider/provider.dart';
import 'package:test_connection_sparky/boxes.dart';
import 'package:test_connection_sparky/pages/recommendation_widget_model.dart';
import 'package:test_connection_sparky/example.dart';
import 'package:test_connection_sparky/inherit.dart';
import 'package:test_connection_sparky/models/recommendation/recommendation_model.dart';
import 'package:test_connection_sparky/models/recommendation_settings/recommendation_settings_model.dart';
import 'package:test_connection_sparky/pages/recommendation_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(RecommendationSettingsAdapter());
  Hive.registerAdapter(RecommendationAdapter());
  recommendBox = await Hive.openBox<Recommendation>('recommendations');
  recommendSettingsBox =
      await Hive.openBox<RecommendationSettings>('recommendSettings');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PhotoModel>(
          create: (context) => PhotoModel(),
        ),
        ChangeNotifierProvider<RecommendationWidgetModel>(
          create: (context) => RecommendationWidgetModel(),
        )
      ],
      child: const MaterialApp(home: RecommendationWidget()),
    );
  }
}
