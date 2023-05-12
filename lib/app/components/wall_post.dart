import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;

  const WallPost({
    super.key,
    required this.message,
    required this.user,
  });

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user,
                  style: TextStyle(
                    fontSize: context.screenWidth * .045,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: context.percentHeight(.01)),
                Text(
                  message,
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
