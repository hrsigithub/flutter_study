import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import 'janken_app.dart';
import 'tweetUI_app.dart';

void main() {
  // runApp(const JankenApp());
  // runApp(const TweetUIApp());
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PixabayPage(),
    );
  }
}

class PixabayPage extends StatefulWidget {
  const PixabayPage({Key? key}) : super(key: key);

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  List hits = [];

  // 非同期通信
  Future<void> fetchImages(String text) async {
    Response res = await Dio().get(
        'https://pixabay.com/api/?key=28425771-40ceff02fb1e573677953406f&q=$text&image_type=photo');

    hits = res.data['hits'];

    setState(() {});
  }

  // 初回にここ動作（最初に１回だけコール）
  @override
  void initState() {
    super.initState();
    fetchImages('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          initialValue: '',
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
          onFieldSubmitted: (text) {
            print(text);
            fetchImages(text);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: hits.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> hit = hits[index];

          return InkWell(
            onTap: () async {
              print(hit['likes']);

              // URL から画像をダウンロード
              Response res = await Dio().get(hit['webformatURL'],
                  options: Options(responseType: ResponseType.bytes));

              // ファイルに保存
              Directory dir = await getTemporaryDirectory();
              File file = await File('${dir.path}' + '/image.png')
                  .writeAsBytes(res.data);

              // Share
              Share.shareFiles([file.path]);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  hit['previewURL'],
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.favorite,
                            size: 14,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text('${hit['likes']}'),
                        ],
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
