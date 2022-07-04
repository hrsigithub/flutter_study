

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';


class PixabayApp extends StatelessWidget {
  const PixabayApp({Key? key}) : super(key: key);

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
  List<PixabayImage> pixabayImages = [];

  // 非同期通信
  Future<void> fetchImages(String text) async {
    final res = await Dio().get(
        'https://pixabay.com/api/',
        queryParameters: {
          'key' : '28425771-40ceff02fb1e573677953406f',
          'q' : text,
          'mage_type': 'photo',
          'per_page' : 100,
          'lang' : 'ja',

        });

    final hits = res.data['hits'] as List;

    pixabayImages = hits.map((e) {
      return PixabayImage.fromMap(e);
    }).toList();

    setState(() {});
  }

// 画像をシェアする。
  Future<void> shareImage(String url) async {
    // URL から画像をダウンロード
    final res = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));

    // ファイルに保存
    final dir = await getTemporaryDirectory();
    final file =
        await File('${dir.path}' + '/image.png').writeAsBytes(res.data);

    // Share
    Share.shareFiles([file.path]);
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
        itemCount: pixabayImages.length,
        itemBuilder: (context, index) {
          final pixabayImage = pixabayImages[index];

          return InkWell(
            onTap: () async {
              // 画像のタップ処理
              print(pixabayImage.likes);

              shareImage(pixabayImage.webformatURL);
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  pixabayImage.previewURL,
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
                          Text('${pixabayImage.likes}'),
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

class PixabayImage {
  final String webformatURL;
  final String previewURL;
  final int likes;

  PixabayImage(
      {required this.webformatURL,
      required this.previewURL,
      required this.likes});

  factory PixabayImage.fromMap(Map<String, dynamic> map) {
    return PixabayImage(
        likes: map['likes'],
        previewURL: map['previewURL'],
        webformatURL: map['webformatURL']);
  }
}



