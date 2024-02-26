import 'package:flutter/material.dart';
import 'package:untitled/db/UserDB/UserInfo.dart';
import 'package:untitled/db/UserDB/user_db_manager.dart';
import 'package:image_picker/image_picker.dart'; // 导入image_picker包
import 'dart:io';

class EditProfileRoute extends StatefulWidget {
  final UserInfo userInfo;

  const EditProfileRoute({Key? key, required this.userInfo}) : super(key: key);

  @override
  _EditProfileRouteState createState() => _EditProfileRouteState();
}

class _EditProfileRouteState extends State<EditProfileRoute> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  String? _avatarPath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userInfo.name);
    _addressController = TextEditingController(text: widget.userInfo.address);
    _avatarPath = widget.userInfo.avatar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑资料"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                backgroundImage: AssetImage(_avatarPath ?? 'assets/avatar/default.jpg'),
                radius: 40,
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '姓名'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: '地址'),
            ),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('更新资料'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery); // 从图库选择图片

    if (pickedFile != null) {
      setState(() {
        _avatarPath = pickedFile.path; // 更新_avatarPath为选中的图片路径
      });
    }
  }

  void _updateProfile() async {
    final dbManager = UserDBManager();
    bool success = await dbManager.updateUserProfile(widget.userInfo.id, _nameController.text, _avatarPath!, _addressController.text);
    if (success) {
      // 构造更新后的userInfo
      UserInfo updatedUserInfo = UserInfo(
        id: widget.userInfo.id,
        email: widget.userInfo.email,
        name: _nameController.text,
        avatar: _avatarPath!,
        address: _addressController.text,
      );
      // 返回更新后的userInfo
      Navigator.pop(context, updatedUserInfo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("更新失败")));
    }
  }

}
