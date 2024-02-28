import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled/widges/community/post_card.dart';//卡片展示
import 'package:untitled/widges/community/carousel_with_indicator.dart'; // 轮播图
import 'package:untitled/widges/community/search_post_screen.dart'; // 假设这是展示搜索结果的页面
import 'package:untitled/db/PostDB/post_db_manager.dart';

class CommunityRoute extends StatefulWidget {
  const CommunityRoute({
    Key? key,
    required this.topPadding,
    required this.MediaWidth,
    required this.MediaHeight,
  }) : super(key: key);

  final double topPadding;
  final double MediaWidth;
  final double MediaHeight;

  @override
  _CommunityRouteState createState() => _CommunityRouteState();
}

class _CommunityRouteState extends State<CommunityRoute> {
  List<Post> posts = [];
  List<Category> categories = [];
  late int selectedCategoryId; // 修改为int类型，用于存储选中的分类ID
  String selectedCategoryName = "狗狗饲养基础"; // 新增变量，用于UI显示选中的分类名称
  TextEditingController _searchController = TextEditingController(); // 添加搜索框控制器
  int _current = 0; // 当前轮播图的索引
  List<Post> carouselPosts = []; // 存放用于展示在轮播图中的帖子

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    final dbManager = PostDBManager();
    var loadedCategories = await dbManager.getAllCategories();
    // 找到选定分类名称对应的ID
    var selectedCategory = loadedCategories.firstWhere(
          (category) => category.name == selectedCategoryName,
      orElse: () => Category(id: 1, name: '热点'), // 如果找不到，则返回一个默认值
    );

    // 由于selectedCategoryName可能会变化，因此在这里直接更新selectedCategoryId
    setState(() {
      categories = loadedCategories;
      selectedCategoryId = selectedCategory.id;
    });
    // 然后根据这个selectedCategoryId来加载相关的帖子
    var loadedPosts = await dbManager.fetchPostsByCategoryId(selectedCategoryId);
    setState(() {
      posts = loadedPosts;
      // 更新轮播图帖子列表
      carouselPosts = posts.take(4).toList();
    });

  }

  void _performSearch() {
    // 定义搜索操作的函数
    String searchText = _searchController.text;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPostScreen(searchText: searchText), // 假设这是搜索结果页面
      ),
    );
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final double sharedMediaWidth = widget.MediaWidth;
    final double sharedMediaHeight = widget.MediaHeight;
    List<Post> filteredPosts = posts.where((post) => post.categoryId == selectedCategoryId).toList();
    if (categories.isEmpty || posts.isEmpty) {
      // 数据还在加载，显示加载指示器
      return Center(child: CircularProgressIndicator());
    }
    // 数据加载完成，显示正常UI
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          // 使用SliverToBoxAdapter来包裹非Sliver部件
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSearchBar(sharedMediaWidth, sharedMediaHeight),
                SizedBox(height: 10),
                _buildCategorySelector(),
                CarouselWithIndicator(posts: carouselPosts), // 使用封装后的轮播图组件
              ],
            ),
          ),
          // 将帖子列表直接作为SliverList
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return _buildPostCard(filteredPosts[index]);
              },
              childCount: filteredPosts.length,
            ),
          ),
        ],
      ),
    );
  }

  // 修改搜索框，添加清空按钮、分隔符和搜索按钮，并调整文本垂直居中
  Widget _buildSearchBar(double sharedMediaWidth, double sharedMediaHeight) {
    return Container(
      width: sharedMediaWidth * 0.99,
      height: sharedMediaHeight * 0.07,
      padding: EdgeInsets.symmetric(horizontal: sharedMediaWidth * 0.05),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center, // 新增：使文本在垂直方向上居中
        decoration: InputDecoration(
          hintText: "搜索社区内容",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min, // 限制Row的宽度仅包裹其子组件
            children: [
              if (_searchController.text.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearSearch, // 点击叉号时执行清空操作
                ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _performSearch, // 点击搜索按钮时执行搜索操作
              ),
            ],
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0), // 调整文本框内边距，左边留出一定空间
        ),
      ),
    );
  }



  Widget _buildCategorySelector() {
    return Container(
      height: 60, // 增加高度以便有足够空间显示下划线
      margin: EdgeInsets.only(top: 10, bottom: 10), // 根据需要调整间距
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (BuildContext context, int index) {
          final category = categories[index];
          bool isSelected = selectedCategoryName == category.name;
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  var category = categories[index];
                  setState(() {
                    selectedCategoryName = category.name;
                    _initializeData(); // 重新加载数据
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: isSelected ? Colors.blue : Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5), // 下划线与文字之间的距离
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 2,
                width: isSelected ? 20 : 0, // 当选中时显示下划线
                color: isSelected ? Colors.blue : Colors.transparent,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPostCard(Post post) {
    return PostCard(post: post);
  }

}
