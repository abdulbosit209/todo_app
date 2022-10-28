import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../data/db/cached_category.dart';
import '../../../../data/db/catched_todos.dart';
import '../../../../data/db/local_database.dart';
import '../../../../global_widgets/my_custom_button.dart';
import '../../../../utils/utility_functions.dart';
import '../../tab_box/widgets/category_item.dart';
import '../../tab_box/widgets/modal_top_view.dart';
import '../../tab_box/widgets/select_date_item.dart';
import '../../tab_box/widgets/select_urgent_level.dart';

class MyUpdateButton extends StatefulWidget {
   MyUpdateButton({Key? key, required this.title, required this.description, required this.categorySelectedIndex, required this.urgentLevel, required this.listenerCallBack, required this.id}) : super(key: key);

   final String title;
   final int id;
   final String description;
   late final int categorySelectedIndex;
   late final int urgentLevel;
   final ValueChanged<bool> listenerCallBack;


  @override
  State<MyUpdateButton> createState() => _MyUpdateButtonState();
}

class _MyUpdateButtonState extends State<MyUpdateButton> {


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

  final TextEditingController titleController = TextEditingController();
  final TextEditingController discriptionController = TextEditingController();

  List<CachedCategory> categories = [];
  List<CachedTodo> cachedUsers = [];
  late final int urgentLevel;


  Future<void> _init() async {
    cachedUsers = (await LocalDatabase.getAllCachedTodo())!.where((element) => element.isDone == 0).toList();
    categories = await LocalDatabase.getAllCachedCategories();
    titleController.text = widget.title;
    discriptionController.text = widget.description;
    urgentLevel = widget.urgentLevel;

    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
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
                                    isSelected: widget.categorySelectedIndex == index,
                                    categoryModel: categories[index],
                                    onTap: () {
                                      setState(() {
                                        widget.categorySelectedIndex = index;
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
                                selectedStarsCount: widget.urgentLevel,
                                onChanged: (v) {
                                  widget.urgentLevel = v;
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
                                        } else if (widget.categorySelectedIndex < 0) {
                                          UtilityFunctions.getMyToast(
                                              message: "Categoryani tanlang!");
                                        } else if (widget.urgentLevel == 0) {
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


                                          // var todoItem = CachedTodo(
                                          //     dateTime: dateTime.toString(),
                                          //     urgentLevel: urgentLevel,
                                          //     todoDescription: descriptionText,
                                          //     todoTitle: titleText,
                                          //     isDone: 0,
                                          //     categoryId: categories[widget.categorySelectedIndex].id!);
                                          await LocalDatabase.updateCachedTodo(id: widget.id, cachedTodo: CachedTodo(
                                              dateTime: dateTime.toString(),
                                              urgentLevel: widget.urgentLevel,
                                              todoDescription: descriptionText,
                                              todoTitle: titleText,
                                              isDone: 0,
                                              categoryId:  categories[widget.categorySelectedIndex].id!));
                                          widget.listenerCallBack(true);
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
        child: Text("update")
    );
  }
  void setDefaults() {
    widget.urgentLevel = 0;
    discriptionController.clear();
    titleController.clear();
    widget.categorySelectedIndex = -1;
  }
}
