import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
  Future<void> fetchImages() async {
    Response res = await Dio().get(
        'https://pixabay.com/api/?key=28425771-40ceff02fb1e573677953406f&q=yellow+flowers&image_type=photo');

    hits = res.data['hits'];

    setState(() {});
  }

  // 初回にここ動作（最初に１回だけコール）
  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: hits.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> hit = hits[index];

          return Image.network(hit['previewURL']);
        },
      ),
    );
  }
}
