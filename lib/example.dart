import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:test_connection_sparky/inherit.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipAddress = dotenv.env['IP_ADDRESS'];
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 400,
            child: Provider.of<PhotoModel>(context).filePath.isEmpty
                ? const Image(
                    image: AssetImage('assets/images/placeholder.jpg'))
                : Image.network(
                    'http://${ipAddress}:8080/static/${Provider.of<PhotoModel>(context).filePath}'),
            // 192.168.43.151
            // Image.network(
            //     'http://192.168.43.151:8080/static/1b5077e4-ff63-4cb9-9258-c97ec4af4159normalno.jpg'),
          ),
          // ElevatedButton(
          //     onPressed: PhotoProvider.read(context)?.notifier?.updatePhoto,
          //     child: Text('Подгрузить фото'))
          ElevatedButton(
              onPressed: Provider.of<PhotoModel>(context).updatePhoto,
              child: Text('Подгрузить фото'))
        ]),
      ),
    );
  }
}
