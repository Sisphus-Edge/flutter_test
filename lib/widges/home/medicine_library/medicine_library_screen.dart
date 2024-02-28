import 'package:flutter/material.dart';
import 'package:untitled/db/MedicineDB/medicine_db_manager.dart';
import 'medicine_detail_screen.dart';
import 'search_medicine_screen.dart';
class MedicineLibraryScreen extends StatefulWidget {
  @override
  _MedicineLibraryScreenState createState() => _MedicineLibraryScreenState();
}

class _MedicineLibraryScreenState extends State<MedicineLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<MedicineCategory> categories = []; // 更新为从数据库读取的药品类别

  @override
  void initState() {
    super.initState();
    _loadCategories(); // 加载药品类别
  }

  void _loadCategories() async {
    final db = MedicineDBManager();
    final loadedCategories = await db.getAllMedicineCategories(); // 从数据库获取药品类别
    setState(() {
      categories = loadedCategories.map((category) => MedicineCategory(
        categoryID: category.categoryID,
        categoryName: category.categoryName,
        icon: category.icon, // 假设 icon 存储的是 icon code
      )).toList();
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  void _performSearch() async {
    final db = MedicineDBManager();
    final searchResults = await db.searchMedicinesByName(_searchController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchResultsScreen(results: searchResults),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('药品库'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(
                  color: Colors.grey, // 边框颜色
                  width: 1, // 边框宽度
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _performSearch,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "请输入要搜索的药品",
                        border: InputBorder.none, // 去除底部边框
                      ),
                      onChanged: (value) {
                        setState(() {}); // 触发界面重建，显示/隐藏清除按钮
                      },
                    ),
                  ),
                  if (_searchController.text.isNotEmpty)
                    GestureDetector(
                      onTap: _clearSearch,
                      child: Icon(Icons.clear, color: Colors.grey),
                    ),
                  VerticalDivider(width: 1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: _performSearch,
                      child: Text("搜索"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 保持每行四个类别
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                IconData iconData = _getIconData(category.icon ?? 'default_icon'); // 提供一个默认图标名称
                return GestureDetector(
                  // 在 MedicineLibraryScreen 的 GridView.builder 中的 onTap 方法内添加跳转逻辑
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicineCategoryScreen(categoryId: category.categoryID,categoryName: category.categoryName),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24, // 增大半径
                        backgroundColor: Colors.blue[100],
                        child: Icon(iconData, color: Colors.blue, size: 24), // 增大图标大小
                      ),
                      SizedBox(height: 8), // 增加图标和文字之间的间距
                      Text(
                        category.categoryName,
                        style: TextStyle(fontSize: 16), // 增大字体大小
                        textAlign: TextAlign.center, // 文字居中
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 60), // 增大按钮高度
              ),
              onPressed: () {
                // 实现问诊开药逻辑
              },
              child: Text(
                '问诊开药',
                style: TextStyle(fontSize: 20), // 增大按钮内文字大小
              ),
            ),
          ),

        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'bug_report':
        return Icons.bug_report;
      case 'healing':
        return Icons.healing;
      case 'restaurant':
        return Icons.restaurant;
      case 'air':
        return Icons.air;
      case 'favorite':
        return Icons.favorite;
      case 'psychology':
        return Icons.psychology;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'visibility':
        return Icons.visibility;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'spa':
        return Icons.spa;
      default:
        return Icons.help; // 默认图标
    }
  }

}
