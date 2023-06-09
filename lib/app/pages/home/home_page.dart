import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/components/drawer_component.dart';
import 'package:projeto_chat_firebase/app/components/textfiled_component.dart';
import 'package:projeto_chat_firebase/app/components/wall_post.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';
import 'package:projeto_chat_firebase/app/core/ui/styles/colors_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final curentUser = FirebaseAuth.instance.currentUser;

  final textEC = TextEditingController();

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  void postMessage() async {
    if (textEC.text.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance.collection('User Posts').add({
      'UserEmail': curentUser!.email,
      'Message': textEC.text,
      'TimeStamp': Timestamp.now(),
      'Likes': [],
    });

    setState(() {
      textEC.clear();
    });
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/profile');
  }

  void signOut() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: context.colorsApp.backgroundd,
          drawer: DrawerComponent(
            onProfileTap: goToProfilePage,
            onSignOutTap: logout,
          ),
          appBar: AppBar(
            title: const Text(
              'Home Chat',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            
            centerTitle: true,
            backgroundColor: Colors.grey[800],
          ),
          body: Center(
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('User Posts')
                        .orderBy('TimeStamp')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final post = snapshot.data!.docs[index];
                            final usuario = post['UserEmail']
                                .toString()
                                .split('@gmail.com');
                            return WallPost(
                              user: usuario[0],
                              message: post['Message'],
                              postId: post.id,
                              likes: List<String>.from(post['Likes'] ?? []),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Erro: ${snapshot.error}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(context.screenWidth * .03),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextfiledComponent.input(
                          hitnText: 'Mensagem',
                          obscureText: false,
                          controllerEC: textEC,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: postMessage,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      curentUser!.email.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.screenHeight * .02),
              ],
            ),
          )),
    );
  }
}
