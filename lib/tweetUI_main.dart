import 'package:flutter/material.dart';
import 'package:flutter_study/TweetTile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ここに記述しないとホットリロード効かない。
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:
             const Text('わいは猿や。プロゴルファー猿じゃ！',
              style: TextStyle(
                fontWeight: FontWeight.bold, // 文字を太く
                fontSize: 16, // 文字サイズを変更,
                // color: Color.fromARGB(0, 222, 40, 158)
                color: Colors.white
              ),
            ),
        ),  // appBar: は位置
        body: SingleChildScrollView(
          child: Column(
           children: const [
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
             TweetTile(),
           ],
           ),
        ),
      ),
    );
  }
}

