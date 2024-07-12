import 'package:app_api/app/config/const.dart';
import 'package:app_api/app/data/api.dart';
import '../register.dart';
import 'package:app_api/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';
import './login.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswordScreen> {
  TextEditingController accountController =
      TextEditingController(text: "21dh1141722");
  TextEditingController numberIdController =
      TextEditingController(text: "01234567890");

  TextEditingController passwordController =
      TextEditingController(text: "123456Abc");

  bool _passwordVisible = false;

  resetpwd() async {
    //lấy token (lưu share_preference)
    String token = await APIRepository()
        .resetPassword(numberIdController.text, accountController.text, passwordController.text);
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    return token;
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    // autoLogin();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset password"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    urlLogo,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image),
                  ),
                  const Text(
                    "LOGIN INFORMATION",
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                  TextFormField(
                    controller: accountController,
                    decoration: const InputDecoration(
                      labelText: "Account ID",
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: numberIdController,
                    decoration: const InputDecoration(
                      labelText: "Number ID",
                      icon: Icon(Icons.perm_identity),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'New password',
                      hintText: 'Enter your new password',
                      // Here is key idea
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: resetpwd,
                        child: const Text("Reset password"),
                      )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
