import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SymptomSelectionScreen extends StatefulWidget {
  final String breed;
  final String gender;
  final String age;
  final String vaccineStatus;
  final String sterilizationStatus;

  SymptomSelectionScreen({
    Key? key,
    required this.breed,
    required this.gender,
    required this.age,
    required this.vaccineStatus,
    required this.sterilizationStatus,
  }) : super(key: key);

  @override
  _SymptomSelectionScreenState createState() => _SymptomSelectionScreenState();
}

class _SymptomSelectionScreenState extends State<SymptomSelectionScreen> {
  // 示例数据
  Map<String, Map<String, List<String>>> symptoms = {
    "常见症状": {
      "体温": ["低烧发热", "高热高烧", "间歇热", "体温降低"],
      "食欲": ["食欲增加", "食欲减少", "食欲丧失", "进食困难/异嗜"],
      "饮水": ["饮水增加", "饮水减少"]
    },
    "精神状况": {
      "精神": ["精神萎靡", "精神亢奋", "晕迷假死", "癫痫", "疼痛/嚎叫", "反应冷漠"],
      "呼吸": ["呼吸加速", "呼吸困难", "咳嗽哮喘", "喘鸣气喘"],
      "体况": ["体重降低", "体重增加", "体况无力", "肢体僵硬", "发育迟缓", "气胸", "肌肉痉挛"]
    },
    "皮肤毛发": {
      "皮肤": ["皮肤粘膜苍白", "皮肤黄疸", "发绀/色素沉着", "水肿/脓包", "皮肤溃疡", "糜烂/流脓", "皮屑鳞屑", "嗜酸性粒细胞", "皮肤炎/毛囊炎", "红斑/丘疹", "痂皮/脓", "皮皮肤结节/疖", "皮肤出血", "缺乏弹性", "皮肤瘙痒"],
      "毛发": ["脱毛掉毛", "被毛杂乱/无光", "跳蚤"]
    },
    "生殖排泄": {
      "排泄": ["粪便恶臭", "软粪", "便秘/粘液便", "腹泻/多次", "便量减少", "便血/深色便", "排尿失禁", "排尿困难", "尿量增加", "尿少/尿石", "蛋白尿", "尿血", "呕吐反胃", "吐血/吐粪"],
      "肛门": ["肛周溃破/沾粪"],
      "阴部": ["阴部分泌/出血", "阴囊肿大/发红"]
    },
    // ... 其他症状分类
  };

  String selectedCategory = "常见症状";
  List<String> selectedSymptoms = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("症状选择"),
      ),
      body: Column(
        children: [
          _buildCategorySelector(),
          _buildSymptoms(),
          _buildSelectedSymptomsSection(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: symptoms.keys.map((category) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Text(category),
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildSymptoms() {
    return Expanded(
      child: ListView(
        children: symptoms[selectedCategory]!.entries.map((entry) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(entry.key, style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Wrap(
              spacing: 8,
              children: entry.value.map((symptom) => ChoiceChip(
                label: Text(symptom),
                selected: selectedSymptoms.contains(symptom),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      selectedSymptoms.add(symptom);
                    } else {
                      selectedSymptoms.remove(symptom);
                    }
                  });
                },
              )).toList(),
            ),
          ],
        )).toList(),
      ),
    );
  }

  Widget _buildSelectedSymptomsSection() {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey[200],
      height: 100, // 设置一个固定高度
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.list, size: 20), // 添加一个图标
              SizedBox(width: 4), // 添加一些间距
              Text("已选症状", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // 水平滚动
              child: Wrap(
                spacing: 8,
                children: selectedSymptoms.map((symptom) => Chip(
                  label: Text(symptom),
                  onDeleted: () {
                    setState(() {
                      selectedSymptoms.remove(symptom);
                    });
                  },
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 修改 _buildActionButtons 来调用 _checkDiseases
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("关闭"),
        ),
        ElevatedButton(
          onPressed: _checkDiseases,
          child: Text("查看疑似疾病"),
        ),
      ],
    );
  }

  Future<void> _checkDiseases() async {
    // 组织发送的数据
    var data = {
      'breed': widget.breed,
      'gender': widget.gender,
      'age': widget.age,
      'vaccineStatus': widget.vaccineStatus,
      'sterilizationStatus': widget.sterilizationStatus,
      'symptoms': selectedSymptoms,
    };
    // 打印发送到后端的数据
    print('Sending to server: $data');

    // 发送请求到后端
    var response = await http.post(
      Uri.parse('YOUR_BACKEND_URL'), // 替换为您的后端URL
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    // 处理响应
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      // 打印从后端接收到的数据
      print('Received from server: $result');
      _showResultDialog(result);
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  void _showResultDialog(dynamic result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("疑似疾病分析结果"),
          content: SingleChildScrollView(
            child: Text(result.toString()), // 显示分析结果
          ),
          actions: <Widget>[
            TextButton(
              child: Text('关闭'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

}
