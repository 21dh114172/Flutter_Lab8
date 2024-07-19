import 'dart:convert';
import '../../page/detail.dart';
import 'package:flutter/material.dart';
import '../../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  User user = User.userEmpty();
  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    print(user);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    // create style
    TextStyle mystyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.amber,
    );
    print(user.imageURL);
    var imageURL = user.imageURL ?? "https://i.imgur.com/WAvsqj5.png";
    return Scaffold(
      appBar: AppBar(
        title: Text('TÀI KHOẢN'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will navigate back to the previous page
          },
        ),
      ),
      body: Detail(),
    );
  }
  
}
