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
      builder: (context) {
        var texto = '';
        if (title == 'unknown') {
          texto = 'Email ou senha incorretos';
        } else if (title == 'invalid-email') {
          texto = 'Email inválido';
        } else if (title == 'user-not-found') {
          texto = 'Usuário não encontrado';
        } else if (title == 'wrong-password') {
          texto = 'Senha incorreta';
        } else {
          texto = 'Erro desconhecido';
        }

        return AlertDialog(
          title: Center(
            child: Text(
              texto,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.redAccent,
        );
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    SizedBox(height: context.percentHeight(.2)),
                    Icon(
                      Icons.lock,
                      size: context.screenHeight * .1,
                      color: Colors.black,
                    ),
                    SizedBox(height: context.percentHeight(.05)),
                    const Text(
                      'Bem vindo ao Social Firebase',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: context.percentHeight(.03)),
                    TextfiledComponent(
                      hitnText: 'Email',
                      obscureText: false,
                      controllerEC: emailEC,
                      color: Colors.black,
                    ),
                    SizedBox(height: context.percentHeight(.02)),
                    TextfiledComponent(
                      hitnText: 'Senha',
                      obscureText: true,
                      controllerEC: passwordEC,
                      color: Colors.black,
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
                          Text(
                            'Não tem uma conta? ',
                            style: TextStyle(color: Colors.black),
                          ),
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
      ),
    );
  }
}
