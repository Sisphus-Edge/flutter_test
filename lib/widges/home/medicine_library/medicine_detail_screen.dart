import 'package:flutter/material.dart';
// import 'package:untitled/db/medicine_db_manager.dart';
import 'package:untitled/db/MedicineDB/medicine_db_manager.dart';

class MedicineCategoryScreen extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  MedicineCategoryScreen({Key? key, required this.categoryId, required this.categoryName}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: FutureBuilder<List<Medicine>>(
        future: MedicineDBManager().getMedicinesByCategory(categoryId), // 异步获取指定类别的药物列表
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 数据加载中，显示加载指示器
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 加载出错，显示错误信息
            return Center(child: Text("加载出错：${snapshot.error}"));
          } else {
            // 数据加载完成，构建显示药物的ListView
            final medicines = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)), // 直角边框
                    child: IntrinsicHeight( // 使用 IntrinsicHeight 来固定高度
                      child: Row(
                        children: <Widget>[
                          Container( // 包裹图片的容器，可以控制图片边距
                            padding: EdgeInsets.all(8), // 设置图片与边框的间距
                            child: Image.asset(
                              medicine.imageUrl?? 'assets/medicineDetail/Albendazole.jpg',//如果为空，则默认
                              width: 80, // 固定图片宽度
                              fit: BoxFit.cover, // 等比例填充
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    medicine.name,
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    medicine.mainFunction,
                                    style: TextStyle(fontSize: 16, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "咨询医生开药",
                                    style: TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicineDetailScreen(name:medicine.name,medicineId: medicine.medicineID), // 修改为传递medicineId
                                  ),
                                );
                              },
                              child: Text("详情", style: TextStyle(fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}


class MedicineDetailScreen extends StatelessWidget {
  final int medicineId;
  final String name;
  MedicineDetailScreen({Key? key, required this.medicineId, required this.name}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: FutureBuilder(
        future: MedicineDBManager().getMedicineDetails(medicineId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // 数据正在加载，显示加载指示器
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // 数据加载出错
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // 数据加载成功，显示药品详情
            final medicine = snapshot.data;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 图片等比例缩放占屏幕宽度的1/3
                  Container(
                    width: double.infinity,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width / 3, // 图片高度设置为屏幕宽度的1/3
                    child: Image.asset(
                      medicine.imageUrl?? 'assets/medicineDetail/Albendazole.jpg',//如果为空，则默认
                      fit: BoxFit.contain, // 修改这里为 BoxFit.contain
                    ),
                  ),
                  // 白底矩形框显示药物名字和购买须知
                  Container(
                    color: Color(0xFFF5F5F5), // 调整为浅灰色背景
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${medicine.name}", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                            "药品购买需咨询医生进行开药，确保医生正确判断病情之后方可购买使用",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  // 主治功能和用法用量的矩形框
                  IntrinsicHeight(
                      child: Row(
                        children: [
                          _buildInfoSection(title: "主治功能",
                              content: medicine.mainFunction,
                              context: context),
                          Container(
                            height: 50, // 根据需要调整高度
                            width: 1,
                            color: Colors.grey, // 竖线颜色
                          ),
                          _buildInfoSection(title: "用法用量",
                              content: medicine.usage,
                              context: context),
                        ],
                      )
                  ),
                  // 药品说明区
                  _buildMedicineInfo(medicine, context),
                ],
              ),
            );
          }
         }
      ),
    );
  }

  Widget _buildInfoSection({required String title, required String content, required BuildContext context}) {
    return Expanded(
      child: Container(
        color: Color(0xFFF5F5F5), // 调整为浅灰色背景
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                InkWell(
                  onTap: () => _showFullTextDialog(context, title, content),
                  child: Icon(Icons.expand_more, color: Colors.blue, size: 20), // 三角形符号
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(content, style: TextStyle(fontSize: 14, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1),
          ],
        ),
      ),
    );
  }


  Widget _buildMedicineInfo(Medicine medicine,BuildContext context) {
    // 定义行的背景颜色
    final rowColors = [
      Color(0xFFF5F5F5), // 浅灰色
      Colors.white,
      Color(0xFFF5F5F5), // 浅灰色
      Colors.white,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text("药品说明", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Table(
          // 设置列宽
          columnWidths: const {
            0: FractionColumnWidth(0.3), // 左列占总宽度的30%
            1: FractionColumnWidth(0.7), // 右列占总宽度的70%
          },
          children: [
            _buildTableRow(context, "适用范围", medicine.description, rowColors[0]),
            _buildTableRow(context, "注意事项", medicine.precautions ?? '未提供', rowColors[1]),
            _buildTableRow(context, "不良反应", medicine.sideEffects ?? '未提供', rowColors[2]),
            _buildTableRow(context, "贮藏", medicine.storage ?? '未提供', rowColors[3]),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow(BuildContext context, String title, String content, Color bgColor) {
    return TableRow(
      decoration: BoxDecoration(color: bgColor),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: InkWell(
            onTap: () => _showFullTextDialog(context, title, content),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    content,
                    maxLines: 1, // 最多显示3行
                    overflow: TextOverflow.ellipsis, // 内容过长时显示省略号
                  ),
                ),
                Icon(Icons.expand_more, color: Colors.blue, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }


  void _showFullTextDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}