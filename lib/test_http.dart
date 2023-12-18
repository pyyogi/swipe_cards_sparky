import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var ipAddress = dotenv.env['IP_ADDRESS'];
final dio = Dio();

Future<MultipartFile> getPhoto() async {
  // Response response;
  var formData = FormData.fromMap({});
  final photoName = "1b5077e4-ff63-4cb9-9258-c97ec4af4159normalno.jpg";
  final response = await dio.getUri(Uri(
      scheme: "http", host: ipAddress, port: 8080, path: "/static/$photoName"));
  final imgBytes = Uint16List.fromList(response.data);
  final img = MultipartFile.fromBytes(imgBytes);

  return img;
}
