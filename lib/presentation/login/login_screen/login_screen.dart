import 'package:flutter/material.dart';
import 'package:todo_app/presentation/login/register_screen/register_screen.dart';
import 'package:todo_app/utils/icons.dart';

import '../../../data/my_repository.dart';
import '../../../data/storage/storage_name.dart';
import '../../../utils/colors.dart';
import '../../../utils/utility_functions.dart';
import '../../tabs/tab_box/tab_box.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

  String savedUserName = "";
  String savedPassword = "";
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();


  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    focusNode2.dispose();
    focusNode1.dispose();

    super.dispose();
  }
  void getInitials(){
    savedUserName = StorageRepository.getString("name");
    print("name: storage ${savedUserName}");
    savedPassword = StorageRepository.getString("password");
    print("password storage ${savedPassword}");

  }

  @override
  void initState() {
    getInitials();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Row(
                children: [
                  SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text("Login", style: TextStyle(fontSize: 25, color: Colors.white),),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 10),
                    child: Text("Username", style: TextStyle(fontSize: 20, color: Colors.white),),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: userNameController,
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
              SizedBox(height: 30),
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
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  focusNode: focusNode2,
                  onSubmitted: (v){
                    focusNode2.unfocus();
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
              SizedBox(height: 100,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF4C4C7C),
                  minimumSize: Size(370, 70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                  )
                ),


                  onPressed: () async {
                String name = userNameController.text;
                String password = passwordController.text;
                if(savedPassword == password && savedUserName == name){
                  await StorageRepository.putBool("isLogged", true);
                  print("password ${password}: ${savedPassword}");
                  print("name ${name}: ${savedUserName}");
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                    return const TabBox();
                  },));



                }else{
                UtilityFunctions.getMyToast(message: 'Login Password Wrong\nRegister first');
                }
              }, child: Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),)),
             SizedBox(height: 20,),
             Row(
               children: const [
                 Expanded(child: Divider(thickness: 5, color: Color(0xFF444444))),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 15),
                   child: Text("or", style: TextStyle(color: Colors.white, fontSize: 20),),
                 ),
                 Expanded(child: Divider(thickness: 5, color: Color(0xFF444444),)),
               ],
             ),
              SizedBox(height: 50),
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
                        Text("Login with Google", style: TextStyle(color: Colors.white, fontSize: 20),)
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
                        Text("Login with Apple", style: TextStyle(color: Colors.white, fontSize: 20),)
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account?", style: TextStyle(color: Colors.white),),
                  TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                          return const MyRegister();
                        }));
                      },
                      child: Text("Register"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

