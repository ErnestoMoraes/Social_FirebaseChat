import 'package:flutter/material.dart';
import 'package:projeto_chat_firebase/app/core/ui/helpers/size_extencion.dart';

class ButtonComponent extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const ButtonComponent({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.percentWidth(.06)),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: context.screenWidth * .05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
