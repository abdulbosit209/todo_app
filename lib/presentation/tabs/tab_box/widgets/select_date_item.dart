import 'package:flutter/material.dart';



class SelectDateItem extends StatelessWidget {
  const SelectDateItem({Key? key, required this.text, required this.onTap}) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
            child: TextButton(
              onPressed: onTap,
              child:  Text(
                text,
                style:
                const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
              ),
            )));
  }
}