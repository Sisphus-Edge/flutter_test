import 'package:flutter/material.dart';
import 'doctor.dart'; // 引入 Doctor 类
import 'process_indicator.dart'; // 引入 ProcessIndicator
import 'rating_stars.dart';// 引入RatingStars
import 'quick_consultation_screen.dart';
import 'start_consultation_page.dart';
class MatchDoctorPage extends StatefulWidget {
  final List<Doctor> doctors;
  MatchDoctorPage({Key? key, required this.doctors}) : super(key: key);

  @override
  _MatchDoctorPageState createState() => _MatchDoctorPageState();
}

class _MatchDoctorPageState extends State<MatchDoctorPage> {
  //final Set<Doctor> _selectedDoctors = {};之前的多选框
  Doctor? _selectedDoctor; // 当前选中的医生
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('匹配医生'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 跳转回“快速问诊的首页”
            Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => QuickConsultationScreen()),
            );
          },
        )
      ),
      body: Column(
        children: <Widget>[
          ProcessIndicator(currentStep: 2), // 假设当前步骤为 2
          Expanded(
            child: ListView.builder(
              itemCount: widget.doctors.length,
              itemBuilder: (context, index) {
                return _buildDoctorCard(widget.doctors[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedDoctor != null){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StartConsultationPage(selectedDoctor: _selectedDoctor!),
              ),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  Widget _buildDoctorCard(Doctor doctor) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Image.asset(doctor.avatarUrl, width: 50, height: 50), // 医生头像
                RatingStars(rating: doctor.rating), // 显示星级评分
              ],
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(doctor.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ), // 医生姓名
                  Text('擅长: ${doctor.specialty}'), // 医生擅长
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[100],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('诊金: ¥${doctor.consultationFee}'), // 诊金
                      Text('接诊量: ${doctor.consultationCount}'), // 接诊量
                    ],
                  ),
                ),
              ],
            ),
            Radio<Doctor>(
              value: doctor,
              groupValue: _selectedDoctor,
              onChanged: (Doctor? value) {
                setState(() {
                  _selectedDoctor = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

}
