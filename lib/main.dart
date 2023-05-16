import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projeto_chat_firebase/app/core/auth/auth/auth.dart';
import 'package:projeto_chat_firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.robotoSlabTextTheme(
            ThemeData.dark().textTheme,
          ),
          hintColor: Colors.amber),
      initialRoute: '/',
      routes: {
        '/': (context) => const Auth(),
      },
    );
  }
}
