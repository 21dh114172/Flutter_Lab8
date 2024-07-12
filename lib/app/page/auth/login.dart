import 'package:app_api/app/config/const.dart';
import 'package:app_api/app/data/api.dart';
import '../register.dart';
import 'package:app_api/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';
import './reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController =
      TextEditingController(text: "21dh1141722");
  TextEditingController passwordController =
      TextEditingController(text: "123456Abc");
  var _passwordVisible = false;
  login() async {
    //lấy token (lưu share_preference)
    String token = await APIRepository()
        .login(accountController.text, passwordController.text);
    var user = await APIRepository().current(token);
    print(user);
    // save share
    saveUser(user);
    //
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Mainpage()));
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
        title: const Text("Login"),
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
                      labelText: "Account",
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'Password',
                      hintText: 'Enter your password',
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
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ResetPasswordScreen()));
                      },
                      child: const Text("Reset password")),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: login,
                        child: const Text("Login"),
                      )),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text("Register"),
                      ))
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
