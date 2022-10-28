import 'package:flutter/material.dart';
import 'package:todo_app/data/storage/storage_name.dart';
import 'package:todo_app/presentation/login/login_screen/login_screen.dart';
import 'package:todo_app/utils/icons.dart';

import '../../utils/colors.dart';
import '../../utils/styles.dart';
import '../on_boarding/boarding_screen.dart';
import '../tabs/tab_box/tab_box.dart';

class MySpashScreen extends StatefulWidget {
  const MySpashScreen({Key? key}) : super(key: key);

  @override
  State<MySpashScreen> createState() => _MySpashScreenState();
}

class _MySpashScreenState extends State<MySpashScreen> {

  bool isLogged = false;
  bool isInitial = false;

  Future<void> _init()async{
    await StorageRepository.getInstance();
    isInitial = StorageRepository.getBool("isInitial");
    print(isInitial);
    isLogged = StorageRepository.getBool("isLogged");
    print(isLogged);

    await Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return isLogged ? TabBox() : isInitial == true ? MyLogin() : MyBoardingScreen();
      }));
    });
  }
  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(MyIcon.splashScreen),
              SizedBox(height: 20),
              Text("UpTodo", style: TextStyle(color: Colors.white, fontSize: 30))
            ],
          ),
        )
      ),
    );
  }
}