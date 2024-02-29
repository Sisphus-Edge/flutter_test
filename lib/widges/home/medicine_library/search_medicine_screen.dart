import 'package:flutter/material.dart';
// 假设有一个相应的Medicine模型和MedicineDBManager数据库管理类
import 'package:untitled/db/MedicineDB/medicine_db_manager.dart';
import 'medicine_detail_screen.dart'; // 确保你有这个药品详情界面

class SearchResultsScreen extends StatelessWidget {
  final List<Medicine> results; // 修改为Medicine类型的列表

  SearchResultsScreen({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final medicine = results[index]; // 修改变量名称和类型
            return Card(
              margin: EdgeInsets.all(6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  // 修改路由跳转到药品详情页，并确保传递正确的参数
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicineDetailScreen(medicineId: medicine.medicineID, name: medicine.name), // 传递medicineId和name
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    medicine.name, // 显示药品名称
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "ZHUOKAI",
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
