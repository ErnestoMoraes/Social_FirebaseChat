import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.only(
        left: context.percentWidth(.05),
        right: context.percentWidth(.05),
        top: context.percentHeight(.015),
      ),
      padding: EdgeInsets.all(context.percentWidth(.04)),
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(isLiked: isLiked, onTap: toogleLike),
              const SizedBox(height: 5),
              Text(
                widget.likes.length.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[900],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user,
                  style: TextStyle(
                    fontSize: context.screenWidth * .045,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: context.percentHeight(.01)),
                Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: context.screenWidth * .045,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
