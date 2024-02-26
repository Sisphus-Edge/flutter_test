import 'package:flutter/material.dart';
// import 'package:untitled/db/db_manager.dart';
import 'package:untitled/db/DiseaseDB/db_manager.dart';

import 'disease_detail_screen.dart';
class DiseaseLibraryScreen extends StatefulWidget {
  @override
  _DiseaseLibraryScreenState createState() => _DiseaseLibraryScreenState();
}

class _DiseaseLibraryScreenState extends State<DiseaseLibraryScreen> {
  List<Department> departments = [];
  Map<int, List<Disease>> diseasesByDepartment = {};
  int? selectedDepartmentId;
  @override
  void initState() {
    super.initState();
    _loadData();
  }
  final TextEditingController _searchController = TextEditingController();
  void _clearSearch() {
    _searchController.clear();
  }

  void _performSearch() {
    // 在这里实现搜索逻辑
    print("执行搜索: ${_searchController.text}");
  }

  Future<void> _loadData() async {
    final db = DBManager();
    final loadedDepartments = await db.getAllDepartments();
    Map<int, List<Disease>> loadedDiseases = {};

    for (var department in loadedDepartments) {
      final diseases = await db.fetchDiseasesByDepartment(department.departmentID);
      loadedDiseases[department.departmentID] = diseases;
    }

    setState(() {
      departments = loadedDepartments;
      diseasesByDepartment = loadedDiseases;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('疾病库'),
      ),
      body: Container(
        color: Colors.grey[200], // 页面背景色
        child: Column(
          children: <Widget>[
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
                          hintText: "请输入要搜索的疾病",
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
              child: Row(
                children: <Widget>[
                  // 部门列表
                  // 使用 Flexible 而不是 Expanded 并指定 flex 值，控制占比为屏幕宽度的1/4
                  Flexible(
                    flex: 1, // 占据可用空间的1/4
                    child: ListView.builder(
                      itemCount: departments.length,
                      itemBuilder: (context, index) {
                        final department = departments[index];
                        bool isSelected = selectedDepartmentId == department.departmentID;
                        return Card(
                          margin: EdgeInsets.all(4), // 调整卡片的外边距
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          color: isSelected ? Colors.blue[100] : Colors.white,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              setState(() {
                                selectedDepartmentId = department.departmentID;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                department.departmentName,
                                style: TextStyle(
                                  color: isSelected ? Colors.blue : Colors.black,
                                  fontFamily: "ZHUOKAI",
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left, // 文本左对齐
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  VerticalDivider(width: 1),
                  // 选定部门的疾病列表
                  // 选定部门的疾病列表
                  Expanded(
                    flex: 3, // 占据剩余的空间
                    child: selectedDepartmentId != null
                        ? ListView.builder(
                      itemCount: diseasesByDepartment[selectedDepartmentId]?.length ?? 0,
                      itemBuilder: (context, index) {
                        final disease = diseasesByDepartment[selectedDepartmentId]![index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DiseaseDetailScreen(disease: disease),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                disease.diseaseName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "ZHUOKAI",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                        : Center(child: Text('请选择一个科室')),
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
