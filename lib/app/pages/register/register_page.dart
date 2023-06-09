import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/components/button_component.dart';
import 'package:projeto_chat_firebase/app/components/textfiled_component.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';
import 'package:projeto_chat_firebase/app/core/ui/styles/colors_app.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onPressed;
  const RegisterPage({super.key, required this.onPressed});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();
  final confirmPasswordEC = TextEditingController();

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    confirmPasswordEC.dispose();
    super.dispose();
  }

  void create() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordEC.text != confirmPasswordEC.text) {
      Navigator.pop(context);
      displayDialog('Senhas não conferem');
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailEC.text,
        password: passwordEC.text,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'username': emailEC.text.split('@')[0],
        'bio': 'Empty bio...',
      });

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colorsApp.backgroundd,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.percentWidth(.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: context.percentHeight(.15)),
                    Icon(
                      Icons.lock,
                      size: context.screenHeight * .1,
                      color: Colors.black,
                    ),
                    SizedBox(height: context.percentHeight(.05)),
                    const Text(
                      'Criar conta no Social Firebase',
                      textAlign: TextAlign.center,
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
                    ),
                    SizedBox(height: context.percentHeight(.02)),
                    TextfiledComponent(
                      hitnText: 'Confirme a senha',
                      obscureText: true,
                      controllerEC: confirmPasswordEC,
                      color: Colors.black,
                    ),
                    SizedBox(height: context.percentHeight(.05)),
                    ButtonComponent(
                      onPressed: create,
                      text: 'Entrar',
                    ),
                    SizedBox(height: context.percentHeight(.03)),
                    GestureDetector(
                      onTap: widget.onPressed,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Já tem uma conta? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            'Logar-se',
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
