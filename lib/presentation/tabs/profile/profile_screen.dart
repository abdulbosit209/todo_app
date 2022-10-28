import 'package:flutter/material.dart';

class MyProfile  extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyBasketState();
}

class _MyBasketState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyProfile"),
      ),
      body: Column(
        children: [
          Text("Under Development")
        ],
      ),
    );
  }
}
