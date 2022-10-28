import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app/data/db/cached_category.dart';
import 'package:todo_app/data/db/local_database.dart';
import 'package:todo_app/presentation/tabs/basket/basket_screen.dart';
import 'package:todo_app/presentation/tabs/done_list/done_list_screen.dart';
import 'package:todo_app/presentation/tabs/profile/profile_screen.dart';
import 'package:todo_app/presentation/tabs/tab_box/widgets/category_item.dart';
import 'package:todo_app/presentation/tabs/tab_box/widgets/modal_top_view.dart';
import 'package:todo_app/presentation/tabs/tab_box/widgets/select_date_item.dart';
import 'package:todo_app/presentation/tabs/tab_box/widgets/select_urgent_level.dart';
import 'package:todo_app/presentation/tabs/todo_list/todo_screen.dart';
import 'package:todo_app/utils/colors.dart';
import '../../../data/db/catched_todos.dart';
import '../../../data/my_repository.dart';
import '../../../global_widgets/my_custom_button.dart';
import '../../../models/category_model.dart';
import '../../../models/todo_model.dart';
import '../../../utils/utility_functions.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
// -----------------------------------------------------------------------------
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

//-----------------------------------------------------------------------------

  Future<void> _init() async {
    cachedUsers = (await LocalDatabase.getAllCachedTodo())!;
    categories = await LocalDatabase.getAllCachedCategories();
    setState(() {});
  }

  @override
  void initState() {
    _init();
    print("length ${categories.length}");
    super.initState();
  }

// ---------------------------------------------------------------------------
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();

  List<ToDoModel> myTodos = [];
  List<CachedCategory> categories = [];
  int categorySelectedIndex = -1;
  int urgentLevel = 0;
  List<CachedTodo> cachedUsers = [];

  int currentIndex = 0;

  List<Widget> screens = [const MyToDoList(), const MyDoneList(), const MyBasket(), const MyProfile()];

  // -------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    print(categories.length);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: MyColors.buttonColor,
        onPressed: () {
          showCupertinoModalBottomSheet(
            context: context,
            isDismissible: false,
            builder: (BuildContext context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: StatefulBuilder(
                  builder: (BuildContext context,
                      void Function(void Function()) setState) {
                    return Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: Container(
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            ModalTopView(
                              text: "Create new todo",
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                    hintText: "To Do title here"),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextField(
                                  controller: discriptionController,
                                  maxLength: 150,
                                  maxLines: 5,
                                  style: const TextStyle(
                                      fontSize: 19, color: Color(0xFF060F17)),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Description here',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    contentPadding: const EdgeInsets.all(13),
                                    fillColor: const Color(0xFFD7D7D7)
                                        .withOpacity(0.2),
                                  ),
                                )),
                            SizedBox(
                              height: 85,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: (BuildContext context, index) {
                                  return CategoryItem(
                                    isSelected: categorySelectedIndex == index,
                                    categoryModel: categories[index],
                                    onTap: () {
                                      setState(() {
                                        categorySelectedIndex = index;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SelectUrgentLevel(
                                selectedStarsCount: urgentLevel,
                                onChanged: (v) {
                                  urgentLevel = v;
                                }),
                            SelectDateItem(
                              text:
                              DateFormat.yMMMd().format(selectedDate),
                              onTap: () async {
                                var t = await _selectDate(context);
                                setState(() {
                                  selectedDate = t;
                                });
                              },
                            ),
                            SelectDateItem(
                              text:
                                  "${selectedTime.hour}:${selectedTime.minute}",
                              onTap: () async {
                                var t = await _selectTime(context);
                                setState(() {
                                  selectedTime = t;
                                });
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: MyCustomButton(
                                    buttonText: "Cancel",
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: MyCustomButton(
                                      buttonText: "Save",
                                      onTap: () async {
                                        String titleText = titleController.text;
                                        String descriptionText =
                                            discriptionController.text;
                                        if (titleText.length < 3) {
                                          UtilityFunctions.getMyToast(
                                              message: "Sarlavxani kiriting!");
                                        } else if (descriptionText.length < 5) {
                                          UtilityFunctions.getMyToast(
                                              message: "Izoh kiriting!");
                                        } else if (categorySelectedIndex < 0) {
                                          UtilityFunctions.getMyToast(
                                              message: "Categoryani tanlang!");
                                        } else if (urgentLevel == 0) {
                                          UtilityFunctions.getMyToast(
                                              message:
                                                  "Muhimlik darajasini tanlang!");
                                        } else {
                                          var dateTime = DateTime(
                                            selectedDate.year,
                                            selectedDate.month,
                                            selectedDate.day,
                                            selectedTime.hour,
                                            selectedTime.minute,
                                          );



                                          // ToDoModel todoModel = ToDoModel(
                                          //   categoryId: categories[
                                          //           categorySelectedIndex]
                                          //       .categoryId,
                                          //   dateTime: dateTime.toString(),
                                          //   isDone: false,
                                          //   todoDescription: descriptionText,
                                          //   todoTitle: titleText,
                                          //   urgentLevel: urgentLevel,
                                          // );
                                          //   MyRepository.addNewTodo(
                                          //     todoModel: todoModel,
                                          //   );


                                            var todoItem = CachedTodo(
                                                dateTime: dateTime.toString(),
                                                urgentLevel: urgentLevel,
                                                todoDescription: descriptionText,
                                                todoTitle: titleText,
                                                isDone: 0,
                                                categoryId: categories[categorySelectedIndex].id!);
                                            await LocalDatabase.insertCachedTodo(todoItem);
                                          _init();
                                          setDefaults();
                                          Navigator.pop(context);
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF363636),
        iconSize: 25,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(color: Colors.white),
        items: [
          getItem(icon: Icons.task, labelText: "Todos"),
          getItem(icon: Icons.done_all, labelText: "Done"),
          getItem(icon: Icons.shopping_basket, labelText: "Basket"),
          getItem(icon: Icons.perm_identity_rounded, labelText: "Profile")
        ],
      ),
    );
  }

  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: Icon(icon, color: Colors.white24),
        activeIcon: Icon(
          icon,
          color: Colors.white,
        ));
  }

  void setDefaults() {
    urgentLevel = 0;
    discriptionController.clear();
    titleController.clear();
    categorySelectedIndex = -1;
  }
}
