import 'dart:convert';
import 'package:app_api/app/model/user.dart';
import 'package:app_api/app/page/auth/profile.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/category/category_list.dart';
import 'package:app_api/app/page/detail.dart';
import 'package:app_api/app/page/history/history_screen.dart';
import 'package:app_api/app/page/home/home_screen.dart';
import 'package:app_api/app/page/product/product_list.dart';
import 'package:app_api/app/route/page3.dart';
import 'package:flutter/material.dart';
import 'app/page/defaultwidget.dart';
import 'app/data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 0;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Trang chủ";
    switch (index) {
      case 0:
        {
          return HomeBuilder();
        }
      case 1:
        {
          return HistoryScreen();
        }
      case 2:
        {
          return CartScreen();
        }
      case 3:
        {
          return const Detail();
        }
      default:
        nameWidgets = "";
        break;
    }
    return DefaultWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HUFLIT"),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            GestureDetector(
              onTap: () {
                // Define the action you want to perform when the image is clicked
                print('Profile image clicked');
                // For example, you might want to navigate to a profile page or show a dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 152, 33),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    user.imageURL!.length < 5
                        ? const SizedBox()
                        : CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              user.imageURL!,
                            )),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(user.fullName!),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Lịch sử'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Giỏ hàng'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Danh mục'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Sản phẩm'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductList()));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.pages),
            //   title: const Text('Page3'),
            //   onTap: () {
            //     Navigator.pop(context);
            //     _selectedIndex = 0;
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => const Page3()));
            //   },
            // ),
            const Divider(
              color: Colors.black,
            ),
            user.accountId == ''
                ? const SizedBox()
                : ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Đăng xuất'),
                    onTap: () {
                      logOut(context);
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'TRANG CHỦ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'LỊCH SỬ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'GIỎ HÀNG',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'TÀI KHOẢN',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
