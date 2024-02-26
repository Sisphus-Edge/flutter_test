import 'package:flutter/material.dart';
import 'package:untitled/db/PostDB/post_db_manager.dart';
import 'PostDetailPage.dart'; // 假设这是文章详情页面

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width / 5;
    double cardHeight = MediaQuery.of(context).size.height / 7;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PostDetailPage(post: post)),
        );
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          height: cardHeight,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    post.imagePath ?? 'assets/image/login/2.png', // 使用 ?? 提供一个默认值
                    width: imageWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          post.title,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              post.tag ?? '宠物之家', // 使用 ?? 提供一个默认值
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            post.date,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
