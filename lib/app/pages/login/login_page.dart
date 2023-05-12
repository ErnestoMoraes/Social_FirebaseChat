import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/components/button_component.dart';
import 'package:projeto_chat_firebase/app/components/textfiled_component.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';
import 'package:projeto_chat_firebase/app/core/ui/styles/colors_app.dart';

class LoginPage extends StatefulWidget {
  final Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await Future.delayed(const Duration(seconds: 2));
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailEC.text,
        password: passwordEC.text,
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayDialog(e.code);
    }
  }

  void displayDialog(String title) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsApp.backgroundd,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.percentWidth(.1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.percentHeight(.1)),
                  Icon(
                    Icons.lock,
                    size: context.screenHeight * .1,
                    color: Colors.black,
                  ),
                  SizedBox(height: context.percentHeight(.05)),
                  const Text(
                      'Bem vindo ao Social Firebase, senti falta de você!'),
                  SizedBox(height: context.percentHeight(.03)),
                  TextfiledComponent(
                    hitnText: 'Email',
                    obscureText: false,
                    controllerEC: emailEC,
                  ),
                  SizedBox(height: context.percentHeight(.02)),
                  TextfiledComponent(
                    hitnText: 'Senha',
                    obscureText: true,
                    controllerEC: passwordEC,
                  ),
                  SizedBox(height: context.percentHeight(.05)),
                  ButtonComponent(
                    onPressed: login,
                    text: 'Entrar',
                  ),
                  SizedBox(height: context.percentHeight(.03)),
                  GestureDetector(
                    onTap: widget.onPressed,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Não tem uma conta?'),
                        Text(
                          'Cadastre-se',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.percentHeight(.02),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
