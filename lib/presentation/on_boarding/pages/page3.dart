import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
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
              Image.asset(MyIcon.boardingPicture3, height: 250, width: 250,),
              SizedBox(height: 20),
              Text("Orgonaize your tasks", style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white),),
              SizedBox(height: 15),
              Text("You can organize your daily tasks by\nadding your tasks into separate categories", textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.white, ),)

            ],
          ),
        ),
      ),
    );
  }
}
