import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';

final ipAddress = dotenv.env['IP_ADDRESS'];
final dio = Dio();

class PhotoModel extends ChangeNotifier {
  String filePath = '';

  void updatePhoto() async {
    // var formData = FormData.fromMap({});
    final filePath =
        'http://${ipAddress}:8080/static/9a510701-1db5-4ac0-893a-7c89f24a030enormalno.jpg';
    // final response = await Dio().get(
    //   'http://localhost:8080/static/1b5077e4-ff63-4cb9-9258-c97ec4af4159normalno.jpg',
    // );

    // final response = await Dio().get(
    //   'http://localhost:8080/static/$photoName',
    //   options: Options(responseType: ResponseType.bytes),
    // );
    // try {
    //   Response response = await dio.getUri(
    //     Uri(
    //         scheme: "http",
    //         host: ipAddress,
    //         port: 8080,
    //         path: "/static/$photoName"),
    //   );

    //   print(response);
    // } catch (e) {
    //   print(e);
    // }

    // final imgBytes = Uint16List.fromList(response.data);
    // final img = MultipartFile.fromBytes(imgBytes);
    // // Получить временную директорию
    // final directory = await getTemporaryDirectory();

    // // Создать путь к файлу
    // final filePath = '${directory.path}/$photoName';

    // // Создать файл
    // final file = File(filePath);

    // // Записать изображение в файл
    // await file.writeAsBytes(imgBytes);

    // // Обновить photoPath
    // filename = filePath;

    // final response = await dio.getUri(
    //   Uri.parse(
    //       'http://192.168.43.151:8080/static/1b5077e4-ff63-4cb9-9258-c97ec4af4159normalno.jpg'),
    // );

    // print('Content-Type: ${response.headers['content-type']}');
    // var formData = FormData.fromMap(
    //     {'email': 'gggg@gmail.com', 'password': 'gggg', 'mode': 'formdata'});
    // try {
    //   var response = await dio.post('http://${ipAddress}:8080/signin',
    //       data: formData, options: Options(
    //     validateStatus: (status) {
    //       return status! < 500;
    //     },
    //   ));
    //   print('Response: ${response}');
    // } on DioException catch (e) {
    //   print(e.response!.statusCode!);
    // }

    notifyListeners();
  }
}

// class PhotoProvider extends InheritedNotifier<PhotoModel> {
//   final PhotoModel photoModel;

//   PhotoProvider({required super.child, required this.photoModel})
//       : super(notifier: photoModel);

//   static PhotoProvider? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<PhotoProvider>()
//         ?.widget;
//     return widget is PhotoProvider ? widget : null;
//   }

//   static PhotoProvider? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<PhotoProvider>();
//   }
// }
