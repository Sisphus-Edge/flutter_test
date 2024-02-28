import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({Key? key}) : super(key: key);

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  XFile? _image;
  String? _base64ImageFromServer; // 从服务器返回的Base64编码图片

  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void uploadImage() async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("请先选择一张图片")));
      return;
    }

    final bytes = await File(_image!.path).readAsBytes();
    String imgBase64 = base64Encode(bytes);
    print("imgBase64:${imgBase64}");
    final String uploadUrl = 'YOUR_BACKEND_IMAGE_UPLOAD_URL';
    try {
      final response = await http.post(
        Uri.parse(uploadUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"image": imgBase64}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("图片上传成功")));

        // 假设服务器返回的响应体就是Base64编码的图片字符串
        setState(() {
          _base64ImageFromServer = jsonDecode(response.body)['image'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("图片上传失败")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("上传异常")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('上传图片', style: TextStyle(fontFamily: 'ZCOOL', fontSize: 22)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text('请选择图片', style: TextStyle(fontFamily: 'ZCOOL', fontSize: 20)),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: pickImage,
                  child: _imageContainer(_image != null ? File(_image!.path) : null, '点击选择图片'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: uploadImage,
                  child: Text('确定上传', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            if (_base64ImageFromServer != null)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _imageContainer(base64Decode(_base64ImageFromServer!), '从服务器加载的图片'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _imageContainer(dynamic content, String placeholderText) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        border: Border.all(color: Colors.purple, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: content != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: content is File
            ? Image.file(content, fit: BoxFit.cover)
            : Image.memory(content, fit: BoxFit.cover),
      )
          : Center(child: Text(placeholderText, style: TextStyle(color: Colors.purple, fontSize: 18))),
    );
  }
}
