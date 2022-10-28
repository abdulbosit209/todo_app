import 'package:flutter/material.dart';
import 'package:todo_app/presentation/login/login_screen/login_screen.dart';
import 'package:todo_app/presentation/on_boarding/pages/page1.dart';
import 'package:todo_app/presentation/on_boarding/pages/page2.dart';
import 'package:todo_app/presentation/on_boarding/pages/page3.dart';
import '../../data/my_repository.dart';
import '../../utils/colors.dart';

class MyBoardingScreen extends StatefulWidget {
  const MyBoardingScreen({Key? key}) : super(key: key);

  @override
  State<MyBoardingScreen> createState() => _MyBoardingScreenState();
}

class _MyBoardingScreenState extends State<MyBoardingScreen> {
  int currentIndex = 0;
  String buttonText = "Next";
  PageController controller = PageController(initialPage: 0);

  List<Widget> screens = [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const MyLogin();
                        },
                      ),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: MyColors.skipColors, fontSize: 15),
                  ),
                ),
              ],
            ),
            Expanded(
                child: PageView(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (pageIndex) {
                print(pageIndex);
              },
              controller: controller,
              children: screens,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: currentIndex == 0
                        ? Colors.white
                        : MyColors.containerColor,
                  ),
                  width: 30,
                ),
                SizedBox(width: 5),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: currentIndex == 1
                        ? Colors.white
                        : MyColors.containerColor,
                  ),
                  width: 30,
                ),
                SizedBox(width: 5),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: currentIndex == 2
                        ? Colors.white
                        : MyColors.containerColor,
                  ),
                  width: 30,
                ),
              ],
            ),
            SizedBox(height: 300),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        if (currentIndex > 0) {
                          setState(() {
                            buttonText = "Next";
                            currentIndex--;
                            controller.jumpToPage(currentIndex);
                          });
                        }
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: MyColors.skipColors, fontSize: 20),
                      )),
                  ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      primary: MyColors.buttonColor,
                      minimumSize: Size(100, 40)
                    ),
                      onPressed: () async {
                        if (currentIndex < 2) {
                          setState(() {
                            currentIndex++;
                            controller.jumpToPage(currentIndex);
                          });
                        } else {

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext context) {
                            return const MyLogin();
                          }));
                        }
                        if (currentIndex == 2) {
                          setState(() {
                            buttonText = "Get started";
                          });
                        }
                      },
                      child: Text(
                        buttonText,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ))
                ],
              ),
            ),
            SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
