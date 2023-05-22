import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/components/comment_buttom.dart';
import 'package:projeto_chat_firebase/app/components/like_button.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final current = FirebaseAuth.instance.currentUser;
  bool isLiked = false;
  final dia = DateTime.now().toString().substring(0, 10);
  final hora = DateTime.now().toString().substring(11, 16);
  final _commentEC = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(current!.email);
  }

  void toogleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([current!.email]),
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([current!.email]),
      });
    }
  }

  void addComment(String commentText) {
    if (commentText.isEmpty) {
      return;
    }

    FirebaseFirestore.instance
        .collection('User Posts')
        .doc(widget.postId)
        .collection('Comments')
        .add({
      'Message': _commentEC.text,
      'CommentedBy': current!.email,
      'CommentTime': Timestamp.now(),
    });
  }

  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add Comment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: _commentEC,
          decoration: const InputDecoration(
            labelText: 'Comment',
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => addComment(_commentEC.text),
            child: const Text('Post'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: current!.email.toString().split('@')[0] == widget.user
            ? Colors.black
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
        left: context.percentWidth(.05),
        right: context.percentWidth(.05),
        top: context.percentHeight(.015),
      ),
      padding: EdgeInsets.all(context.percentWidth(.04)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.user,
                          style: TextStyle(
                            fontSize: context.screenWidth * .047,
                            color: current!.email.toString().split('@')[0] ==
                                    widget.user
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          hora,
                          style: TextStyle(
                            fontSize: context.screenWidth * .035,
                            color: current!.email.toString().split('@')[0] ==
                                    widget.user
                                ? Colors.white
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.screenWidth * .01),
                    Text(
                      widget.message,
                      style: TextStyle(
                        fontSize: context.screenWidth * .045,
                        color: current!.email.toString().split('@')[0] ==
                                widget.user
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  LikeButton(isLiked: isLiked, onTap: toogleLike),
                  const SizedBox(height: 5),
                  Text(
                    widget.likes.length.toString(),
                    style: TextStyle(
                      color:
                          current!.email.toString().split('@')[0] == widget.user
                              ? Colors.white
                              : Colors.black54,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  CommentButtom(onTap: showCommentDialog),
                  const SizedBox(height: 5),
                  Text(
                    '0',
                    style: TextStyle(
                      color:
                          current!.email.toString().split('@')[0] == widget.user
                              ? Colors.white
                              : Colors.black54,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
