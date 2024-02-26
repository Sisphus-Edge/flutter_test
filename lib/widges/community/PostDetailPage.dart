import 'package:flutter/material.dart';
import 'package:untitled/db/PostDB/post_db_manager.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;

  const PostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 标题
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                post.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            // 图片
            Center(
              child: Image.asset(
                post.imagePath ?? 'assets/image/login/2.png', // 使用 ?? 提供一个默认值
                fit: BoxFit.cover,
              ),
            ),
            // 文字介绍
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                post.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
            // 作者和日期
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "作者: ${post.author}",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(width: 10), // 用于添加一点间距
                  Text(
                    post.date,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
