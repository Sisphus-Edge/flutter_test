import 'package:flutter/material.dart';
import 'package:untitled/db/PostDB/post_db_manager.dart';
import 'package:untitled/widges/community/post_card.dart';

class SearchPostScreen extends StatefulWidget {
  final String searchText;

  const SearchPostScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchPostScreenState createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  late Future<List<Post>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = _performSearch(widget.searchText);
  }

  Future<List<Post>> _performSearch(String query) async {
    final dbManager = PostDBManager();
    return await dbManager.searchPostsByTitle(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('发生错误: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return Center(child: Text('没有找到相关结果' ,style: TextStyle(
                fontFamily: "ZHUOKAI",
                fontWeight: FontWeight.w400,
                fontSize: 20,
                letterSpacing: 4.0,
                color: Colors.black
            ),));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return PostCard(post: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
