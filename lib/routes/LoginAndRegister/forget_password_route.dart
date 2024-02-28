import 'package:flutter/material.dart';
import 'package:untitled/db/UserDB/user_db_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:untitled/routes/loginRoute.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ForgetPasswordRoute extends StatefulWidget {
  @override
  _ForgetPasswordRouteState createState() => _ForgetPasswordRouteState();
}

class _ForgetPasswordRouteState extends State<ForgetPasswordRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _newPassword = '';
  String _confirmPassword = '';
  String _verificationCode = '';
  bool isCodeSent = false;
  // 定义TextEditingController
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("找回密码")),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[
            SizedBox(height: 20),
            Image.asset('assets/image/login/2.png', height: 200, width: double.infinity, fit: BoxFit.cover),
            SizedBox(height: 20),
            buildEmailTextField(),
            buildNewPasswordTextField(),
            buildConfirmPasswordTextField(),
            buildVerificationCodeField(),
            SizedBox(height: 20),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildEmailTextField() {
    return TextFormField(
      controller: _emailController, // 使用控制器
      decoration: InputDecoration(labelText: '请输入邮箱'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '邮箱不能为空';
        }
        if (!isEmailValid(value)) {
          return '请输入有效的邮箱地址';
        }
        return null;
      },
    );
  }

  Widget buildNewPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: '请输入新密码'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '密码不能为空';
        }
        if (!isPasswordValid(value)) {
          return '密码需8-16位，包含字母和数字，不含特殊字符';
        }
        return null;
      },
      onChanged: (value) {
        // 在这里更新新密码的状态
        setState(() {
          _newPassword = value;
        });
      },
      onSaved: (value) => _newPassword = value!,
    );
  }

  Widget buildConfirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: '请再次确认密码'),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '确认密码不能为空';
        }
        if (value != _newPassword) {
          // 直接使用_newPassword变量进行比较
          return '两次输入的密码不匹配';
        }
        return null;
      },
      onSaved: (value) => _confirmPassword = value!,
    );
  }


  Widget buildVerificationCodeField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: '请输入验证码'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '验证码不能为空';
              }
              return null;
            },
            onSaved: (value) => _verificationCode = value!,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // 直接从控制器中获取手机号
            String email = _emailController.text;
            print("邮箱如下: $email");
            if (email.isNotEmpty) {
              sendVerificationCode(email);
              setState(() {
                isCodeSent = true;
              });
            } else {
              // 提示用户输入邮箱
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("请输入邮箱")));
            }
          },
          child: Text('发送验证码'),
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // 调用验证码验证函数
          bool verificationPassed = await checkVerificationCode(_emailController.text, _verificationCode);

          if (verificationPassed && _newPassword == _confirmPassword) {
            // 实例化UserDBManager
            final dbManager = UserDBManager();

            // 调用updateUserPassword方法更新密码
            bool updateSuccess = await dbManager.updateUserPassword(_emailController.text, _newPassword);

            if (updateSuccess) {
              // 更新成功，显示成功消息并可能跳转到登录页面或其他操作
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("密码更新成功，请重新登录。")),
              );
              // 可以选择在这里跳转到登录页或其他页面
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginRoute()),
              );
            } else {
              // 更新失败，可能是因为邮箱未找到
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("密码更新失败，请检查邮箱是否正确。")),
              );
            }
          } else {
            // 验证码不正确或密码不匹配的处理逻辑
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("验证码错误或密码不匹配")),
            );
          }
        }
      },
      child: Text('提交'),
    );
  }


  bool isEmailValid(String email) {
    // 邮箱的正则表达式
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid(String password) {
    // 密码的正则表达式
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,16}$');
    return passwordRegex.hasMatch(password);
  }

  Future<void> sendVerificationCode(String email) async {
    print("执行sendVerificationCode！");
    final uri = Uri.parse('http://10.230.8.14:8081/api/user/code');
    final response = await http.post(uri, body: {
      'email': email,
      // 可能还需要其他参数，根据API的要求
    });
    if (response.statusCode == 200) {
      // 请求成功，处理响应
      final data = jsonDecode(response.body);
      print('验证码发送成功: $data');
      // 根据返回的数据进行处理，比如更新UI提示用户验证码已发送
    } else {
      // 请求失败，处理错误
      print('验证码发送失败: ${response.body}');
      // 根据错误进行处理，比如提示用户重试
    }
  }

  // 假设添加一个新函数checkVerificationCode，用于验证验证码
  Future<bool> checkVerificationCode(String email, String verificationCode) async {
    print("执行checkVerificationCode");
    final uri = Uri.parse('http://10.230.8.14:8081/api/user/login');
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // 设置请求头
      },
      body: jsonEncode({
        'email': email,
        'code': verificationCode, // 用户输入的验证码
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['success']; // 假设API返回的格式中有个success字段表示验证是否成功
    } else {
      // 如果请求失败，可以根据需要处理，比如打印日志或者返回false
      print('验证码验证失败: ${response.body}');
      return false;
    }
  }

}
