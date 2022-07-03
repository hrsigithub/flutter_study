import 'package:flutter/material.dart';


class TweetTile extends StatelessWidget {
  const TweetTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 上揃えにする
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://img.gamewith.jp/article_tools/pad/gacha/8932.png'),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 左
            children: [
              Row(children: const [
                Text('しゃーくど'),
                SizedBox(width: 8), // 隙間
                Text('2022/05/05'),
              ],
              ),
              const SizedBox(height: 14),
              const Text('最高でした。'),
              IconButton(
               onPressed: () {},
               icon: const Icon(Icons.favorite_border),
             ),

            ],

          ),
        ],
      ),
    );
  }
}
