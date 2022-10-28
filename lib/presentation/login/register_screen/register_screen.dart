import 'package:flutter/material.dart';
import 'package:todo_app/data/storage/storage_name.dart';
import 'package:todo_app/presentation/login/login_screen/login_screen.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/icons.dart';
import 'package:todo_app/utils/utility_functions.dart';

import '../../../data/my_repository.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();

  @override
  void dispose() {

    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    focusNode2.dispose();
    focusNode1.dispose();
    focusNode3.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                children: const [
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Register", style: TextStyle(fontSize: 25, color: Colors.white),),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: const [
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text("Username", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: usernameController,
                  focusNode: focusNode1,
                  onSubmitted: (v){
                    UtilityFunctions.fieldFocusChange(context, focusNode1, focusNode2);
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      filled: true,
                      fillColor: MyColors.textFieldColor,
                      hintText: "Enter the username",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: const [
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text("Email", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: emailController,
                  focusNode: focusNode2,
                  onSubmitted: (v){
                    UtilityFunctions.fieldFocusChange(context, focusNode2, focusNode3);
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      filled: true,
                      fillColor: MyColors.textFieldColor,
                      hintText: "Enter the email",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: const [
                  SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text("Password", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: passwordController,
                  focusNode: focusNode3,
                  onSubmitted: (v){
                    focusNode3.unfocus();
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF979797), width: 2),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      filled: true,
                      fillColor: MyColors.textFieldColor,
                      hintText: "Enter the password",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF4C4C7C),
                      minimumSize: Size(370, 70),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      )
                  ),
                  onPressed: () async {
                    if(usernameController.text.isNotEmpty &&
                        emailController.text.trim().length > 3 &&
                        passwordController.text.trim().length > 3){

                      await MyRepository.getInitialValue();
                      await StorageRepository.putString(key: "name", value: usernameController.text);
                      await StorageRepository.putString(key: "email",value:  emailController.text);
                      await StorageRepository.putString(key: "password", value: passwordController.text);


                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return const MyLogin();
                      }));
                    }
                  }, child: Text("Register", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)),
              SizedBox(height: 20,),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 2, color: Color(0xFF444444))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text("or", style: TextStyle(color: Colors.white, fontSize: 20),),
                  ),
                  Expanded(child: Divider(thickness: 2, color: Color(0xFF444444),)),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF8875FF)),
                      color: MyColors.backgroundColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(MyIcon.googlePicture, height: 30, width: 30,),
                        SizedBox(width: 10),
                        Text("Register with Google", style: TextStyle(color: Colors.white, fontSize: 20),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: InkWell(
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFF8875FF)),
                      color: MyColors.backgroundColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(MyIcon.applePicture, height: 40, width: 40,),
                        SizedBox(width: 10),
                        Text("Register with Apple", style: TextStyle(color: Colors.white, fontSize: 20),)
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ", style: TextStyle(color: Colors.white),),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return const MyLogin();
                        }));
                      },
                      child: Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
  if(usernameController.text.isNotEmpty &&
                 emailController.text.trim().length > 3 &&
                 passwordController.text.trim().length > 3){

                await StorageRepository.putString(key: "name", value: usernameController.text);
                await StorageRepository.putString(key: "email",value:  emailController.text);
                await StorageRepository.putString(key: "password", value: passwordController.text);

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                  return const MyLogin();
                }));
 */