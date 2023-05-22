// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';

class CommentButtom extends StatefulWidget {
  final void Function()? onTap;
  const CommentButtom({
    super.key,
    required this.onTap,
  });

  @override
  State<CommentButtom> createState() => _CommentButtomState();
}

class _CommentButtomState extends State<CommentButtom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: context.percentWidth(.02),
        right: context.percentWidth(.02),
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Icon(
          Icons.comment,
          color: Colors.grey,
          size: context.percentWidth(.07),
        ),
      ),
    );
  }
}
