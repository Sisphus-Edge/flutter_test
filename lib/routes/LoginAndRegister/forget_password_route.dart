import 'package:flutter/material.dart';
import 'package:untitled/db/UserDB/user_db_manager.dart';
import 'package:drift/drift.dart' as drift;
import 'package:untitled/routes/loginRoute.dart';
class ForgetPasswordRoute extends StatefulWidget {
  @override
  _ForgetPasswordRouteState createState() => _ForgetPasswordRouteState();
}

class _ForgetPasswordRouteState extends State<ForgetPasswordRoute> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _newPassword = '';
  String _confirmPassword = '';
  String _verificationCode = '';
  bool isCodeSent = false;

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
      onSaved: (value) => _email = value!,
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
            // 实现发送验证码到邮箱的逻辑
            print("发送验证码");
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
          // 假设验证码已经验证通过
          var verificationPassed = true; // 实际应用中需要替换为验证码验证逻辑

          if (verificationPassed && _newPassword == _confirmPassword) {
            // 实例化UserDBManager
            final dbManager = UserDBManager();

            // 调用updateUserPassword方法更新密码
            bool updateSuccess = await dbManager.updateUserPassword(_email, _newPassword);

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
}
