import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:test_connection_sparky/models/recommendation/recommendation_model.dart';
import 'package:test_connection_sparky/pages/recommendation_widget_model.dart';

// class RecommendationWidget extends StatelessWidget {
//   const RecommendationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<RecommendationWidgetModel>(
//       builder: (context, model, child) {
//         print('model.recommendations: ${model.recommendations}');
//         return FutureBuilder<List<Recommendation>>(
//           future: model.showRecommends(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                   child: CircularProgressIndicator()); // Отображение загрузчика
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}'); // Отображение ошибки
//             } else {
//               return snapshot.data == null || snapshot.data!.isEmpty
//                   ? Text(
//                       'No data') // Отображение сообщения, если данные отсутствуют
//                   : Draggable(
//                       child: RecommendCardWidget(
//                           recommendation:
//                               snapshot.data![model.getCurrentIdx()]),
//                       feedback: RotationTransition(
//                         turns: AlwaysStoppedAnimation(0),
//                         child: RecommendCardWidget(
//                             recommendation:
//                                 snapshot.data![model.getCurrentIdx()]),
//                       ),
//                       onDragEnd: (drag) {
//                         if (drag.velocity.pixelsPerSecond.dx < 0) {
//                           model.sendReaction(userId,
//                               snapshot.data![model.getCurrentIdx()].id, false);
//                         } else {
//                           model.sendReaction(userId,
//                               snapshot.data![model.getCurrentIdx()].id, true);
//                         }
//                         model.increaseCurrentIdx();
//                       },
//                     );
//             }
//           },
//         );
//       },
//     );
//   }
// }

// class RecommendationWidget extends StatelessWidget {
//   const RecommendationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Recommendation>>(
//         future: Provider.of<RecommendationWidgetModel>(context).showRecommend(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             List<Recommendation> recommendations = snapshot.data!;

//             return Center(
//                 child: Text(
//                     '${recommendations[4].name}, ${recommendations.length}'));
//             // SwipeCards(
//             //   matchEngine: (){

//             //   },
//             //   itemBuilder: (BuildContext context, int index) {
//             //     return RecommendCardWidget(
//             //         recommendation: recommendations[index]);
//             //   },
//             //   onStackFinished: () {
//             //     // This function is triggered when all the cards have been swiped.
//             //     // You can use this function to load more cards or show a message.
//             //   },
//             //   itemChanged: (SwipeItem item, int index) {
//             //     // This function is triggered when item in the stack changes (moves to next card).
//             //     // You can use this function to update your UI or send a reaction to the server.
//             //     if (item.isLiked) {
//             //       sendReaction(userId, item.id, true);
//             //     } else {
//             //       sendReaction(userId, item.id, false);
//             //     }
//             //   },
//             //   upSwipeAllowed: false,
//             //   leftSwipeAllowed: true,
//             //   rightSwipeAllowed: true,

//             //   fillSpace: true,
//             // );
//           }
//         },
//       ),
//     );
//   }
// }

class RecommendationWidget extends StatelessWidget {
  const RecommendationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<Recommendation>>(
            future: Provider.of<RecommendationWidgetModel>(context)
                .showRecommends(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Recommendation> recommendations = snapshot.data!;
                Recommendation recommendation = recommendations[
                    Provider.of<RecommendationWidgetModel>(context)
                        .getCurrentIdx()];
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Stack(children: [
                      Draggable(
                        // axis: Axis.horizontal,
                        childWhenDragging:
                            RecommendCardWidget(recommendation: recommendation),
                        child: RecommendCardWidget(
                          recommendation: recommendation,
                        ),
                        feedback: RecommendCardWidget(
                          recommendation: recommendation,
                        ),

                        // Transform.scale(
                        //   scale: 1.2,
                        // child: RecommendCardWidget(
                        //   recommendation: recommendation,
                        // ),
                        // ),
                        onDragEnd: (drag) {
                          if (drag.velocity.pixelsPerSecond.dx < 0) {
                            Provider.of<RecommendationWidgetModel>(context,
                                    listen: false)
                                .sendReaction(userId, recommendation.id, false);
                            print("Swiped left");
                          } else {
                            Provider.of<RecommendationWidgetModel>(context,
                                    listen: false)
                                .sendReaction(userId, recommendation.id, true);
                            print("Swiped right");
                          }
                        },
                      ),
                    ]),
                  ),
                );
              }
            }));
  }
}

class RecommendCardWidget extends StatelessWidget {
  final Recommendation recommendation;
  const RecommendCardWidget({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'http://$ipAddress:8080/${recommendation.imgPath}')),
                borderRadius: BorderRadius.circular(5.0)),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: const LinearGradient(colors: [
                  Color.fromARGB(200, 0, 0, 0),
                  Color.fromARGB(0, 0, 0, 0),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          CardBottomWidget(recommendation: recommendation)

          // Positioned(
          //   bottom: 30,
          //   left: 20,
          //   child: Column(
          //     children: [
          //       Text(
          //         '${recommendation.name}, ${recommendation.age}',
          //         style: TextStyle(fontSize: 24, color: Colors.white),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),

      // child: Text(recommendation.toString()),
    );
  }
}

class CardBottomWidget extends StatelessWidget {
  const CardBottomWidget({
    super.key,
    required this.recommendation,
  });

  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '${recommendation.name}, ${recommendation.age}',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Provider.of<RecommendationWidgetModel>(context,
                          listen: false)
                      .sendReaction(userId, recommendation.id, false),
                  child: const ChoiceButton(
                    width: 60,
                    height: 60,
                    size: 25,
                    color: Colors.deepOrange,
                    icon: Icons.clear_rounded,
                    background: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => Provider.of<RecommendationWidgetModel>(context,
                          listen: false)
                      .sendReaction(userId, recommendation.id, true),
                  child: const ChoiceButton(
                    width: 60,
                    height: 60,
                    size: 25,
                    color: Colors.white,
                    icon: Icons.favorite,
                    background: Colors.deepOrange,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final Color color;
  final Color background;

  final IconData icon;

  const ChoiceButton(
      {super.key,
      this.width = 60,
      this.height = 60,
      this.size = 25,
      required this.color,
      required this.icon,
      required this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: background,
        boxShadow: [
          BoxShadow(
              spreadRadius: 4, blurRadius: 4, color: Colors.grey.withAlpha(50))
        ],
      ),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
