import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/pages/login/login_page.dart';
import 'package:projeto_chat_firebase/app/pages/register/register_page.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  bool showLoginPage = true;

  void changePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onPressed: changePage,
      );
    } else {
      return RegisterPage(
        onPressed: changePage,
      );
    }
  }
}
