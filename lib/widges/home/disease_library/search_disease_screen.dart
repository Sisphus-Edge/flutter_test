import 'package:flutter/material.dart';
import 'package:untitled/db/DiseaseDB/db_manager.dart';
import 'disease_detail_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  final List<Disease> results;

  SearchResultsScreen({Key? key, required this.results}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索结果'),
      ),
      body: Padding( // 添加Padding来设置左右的边距
        padding: const EdgeInsets.symmetric(horizontal: 8.0), // 设置水平方向的边距
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final disease = results[index];
            return Card(
              margin: EdgeInsets.all(6), // 调整卡片的外边距
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
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
