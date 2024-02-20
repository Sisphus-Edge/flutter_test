import 'package:flutter/material.dart';
import 'package:untitled/db/db_manager.dart';

class DiseaseDetailScreen extends StatefulWidget {
  final Disease disease;

  const DiseaseDetailScreen({Key? key, required this.disease}) : super(key: key);

  @override
  _DiseaseDetailScreenState createState() => _DiseaseDetailScreenState();
}

class _DiseaseDetailScreenState extends State<DiseaseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String departmentName = '加载中...'; // 添加科室名称状态变量
  // 定义文本样式
  final TextStyle infoTextStyle = TextStyle(fontSize: 18, height: 1.5); // 调整字体大小和行高

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadDepartmentName();
  }

  Future<void> _loadDepartmentName() async {
    if (widget.disease.departmentID != null) {
      final name = await DBManager().getDepartmentNameById(widget.disease.departmentID!);
      if (name != null) {
        setState(() {
          departmentName = name;
        });
      } else {
        setState(() {
          departmentName = '未知科室';
        });
      }
    } else {
      setState(() {
        departmentName = '未知科室';
      });
    }
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.disease.diseaseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.disease.diseaseName,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '所属科室: $departmentName', // 使用状态变量显示科室名称
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  // 假设图片URL已正确设置
                  Image.asset(
                    widget.disease.imageUrl ?? 'assets/images/placeholder.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontSize: 18), // 调整Tab文本的大小
              tabs: [
                Tab(text: '简介'),
                Tab(text: '症状'),
                Tab(text: '病因'),
                Tab(text: '预防'),
                Tab(text: '治疗'),
                Tab(text: '诊断'),
              ],
            ),
            Container(
              height: 300, // 设置内容区域高度
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Text(widget.disease.description ?? '暂无详细介绍', style: infoTextStyle),
                  Text(widget.disease.symptoms ?? '暂无信息', style: infoTextStyle),
                  Text(widget.disease.cause ?? '暂无信息', style: infoTextStyle),
                  Text(widget.disease.prevention ?? '暂无信息', style: infoTextStyle),
                  Text(widget.disease.treatment ?? '暂无信息', style: infoTextStyle),
                  Text(widget.disease.diagnosis ?? '暂无信息', style: infoTextStyle),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
