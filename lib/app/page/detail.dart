import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
      color: Color.fromARGB(255, 66, 66, 66),
    );
    print(user.imageURL);
    var imageURL = user.imageURL ?? "https://i.imgur.com/WAvsqj5.png";
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            user.imageURL!.length < 5
                ? const SizedBox()
                : CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      user.imageURL!,
                    )),
            Text("NumberID: ${user.idNumber}", style: mystyle),
            Text("Fullname: ${user.fullName}", style: mystyle),
            Text("Phone Number: ${user.phoneNumber}", style: mystyle),
            Text("Gender: ${user.gender}", style: mystyle),
            Text("birthDay: ${user.birthDay}", style: mystyle),
            Text("schoolYear: ${user.schoolYear}", style: mystyle),
            Text("schoolKey: ${user.schoolKey}", style: mystyle),
            Text("dateCreated: ${user.dateCreated}", style: mystyle),
          ]),
        ),
      ),
    );
  }
}
