import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Image.asset(MyIcon.boardingPicture2, height: 250, width: 250,),
              SizedBox(height: 20),
              Text("Create daily routine", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),),
              SizedBox(height: 15),
              Text("In Uptodo  you can create your\npersonalized routine to stay productive", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white, ),)

            ],
          ),
        ),
      ),
    );
  }
}
