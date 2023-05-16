// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  void Function() onTap;

  LikeButton({
    Key? key,
    required this.isLiked,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: context.percentWidth(.03)),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.grey,
          size: context.percentWidth(.07),
        ),
      ),
    );
  }
}
