import 'package:flutter/material.dart';
import 'symptom_selection_screen.dart';
class AISelfCheckScreen extends StatefulWidget {
  @override
  _AISelfCheckScreenState createState() => _AISelfCheckScreenState();
}

class _AISelfCheckScreenState extends State<AISelfCheckScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedBreed = "土狗";
  String _selectedGender = "公";
  String _selectedAge = "半岁以下";
  String _selectedVaccine = "已接种";
  String _selectedSterilization = "未绝育";

  void _showFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("填写狗狗基本信息"),
              content: _buildFormContent(setState),
              actions: _buildDialogActions(context),
            );
          },
        );
      },
    );
  }

  Widget _buildFormContent(StateSetter setState) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            _buildDropdownField("种类", ["土狗", "哈士奇", "金毛", "..."], _selectedBreed, (newValue) {
              setState(() {
                _selectedBreed = newValue!;
              });
            }),
            _buildDropdownField("性别", ["公", "母"], _selectedGender, (newValue) {
              setState(() {
                _selectedGender = newValue!;
              });
            }),
            _buildDropdownField("年龄", ["半岁以下", "半岁至三岁", "三岁至七岁", "七岁以上"], _selectedAge, (newValue) {
              setState(() {
                _selectedAge = newValue!;
              });
            }),
            _buildDropdownField("疫苗情况", ["已接种", "未接种"], _selectedVaccine, (newValue) {
              setState(() {
                _selectedVaccine = newValue!;
              });
            }),
            _buildDropdownField("绝育情况", ["未绝育", "已绝育"], _selectedSterilization, (newValue) {
              setState(() {
                _selectedSterilization = newValue!;
              });
            }),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDialogActions(BuildContext context) {
    return [
      _buildDialogButton('关闭', () => Navigator.of(context).pop()),
      _buildDialogButton('症状选择', () {
        if (_formKey.currentState!.validate()) {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SymptomSelectionScreen(
              breed: _selectedBreed,
              gender: _selectedGender,
              age: _selectedAge,
              vaccineStatus: _selectedVaccine,
              sterilizationStatus: _selectedSterilization,
            ),
          ));
        }
      }),
    ];
  }


  Widget _buildDialogButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "ZHUOKAI",
              fontWeight: FontWeight.w400,
              fontSize: 16,
              letterSpacing: 2.0,
              color: Colors.black,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }


  Widget _buildDropdownField(String label, List<String> items, String currentValue, ValueChanged<String?> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        DropdownButton<String>(
          value: currentValue,
          onChanged: (String? newValue) {
            onChanged(newValue);
          },
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI辅助自查"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            _buildSystemIntroSection(),
            SizedBox(height: 20),
            _buildStartCheckButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemIntroSection() {
    return Column(
      children: [
        _buildDecoratedTitle("系统介绍"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "本系统利用先进的宠物疾病特征向量AI诊疗技术，结合数据挖掘、机器学习和算法模型，构建了全面的疾病、特征、生化、药物关系数据库。我们的目标是通过辅助诊疗、自助诊断、治疗方案生成和宠物健康知识的普及，为宠物提供全面、科学、系统的医疗服务。这一创新方式将开启透明、可靠的宠物健康管理新时代。",
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 16.0,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDecoratedTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildStartCheckButton() {
    return ElevatedButton(
      onPressed: () => _showFormDialog(context),
      child: Text("开始自查"),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
    );
  }
}
