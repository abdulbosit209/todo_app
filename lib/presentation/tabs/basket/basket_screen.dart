import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app/presentation/tabs/basket/widgets/basket_item.dart';
import 'package:todo_app/presentation/tabs/basket/widgets/custom_update_buttom.dart';

import '../../../data/db/cached_category.dart';
import '../../../data/db/catched_todos.dart';
import '../../../data/db/local_database.dart';
import '../tab_box/widgets/modal_top_view.dart';

class MyBasket extends StatefulWidget {
  const MyBasket({Key? key}) : super(key: key);

  @override
  State<MyBasket> createState() => _MyBasketState();
}

class _MyBasketState extends State<MyBasket> {
  final TextEditingController titleController = TextEditingController();
  List<CachedTodo> deletedTodos = [];
  List<CachedCategory> categories = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    deletedTodos = (await LocalDatabase.getAllCachedTodo())!
        .where((element) => element.isDone == 2)
        .toList();
    categories = await LocalDatabase.getAllCachedCategories();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("basket"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Do you want delete all todos"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("cancel")),
                            TextButton(
                                onPressed: () async {
                                  await LocalDatabase.deleteAllCachedTodos();
                                  _init();
                                  Navigator.pop(context);
                                },
                                child: Text("ok")),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.clear))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _init();
          },
          child: ListView(
            children: List.generate(deletedTodos.length, (index) {
              var toDO = deletedTodos[index];
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 5,
                        offset: const Offset(1, 3),
                        blurRadius: 5,
                        color: Colors.grey.shade300,
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          deletedTodos[index].todoTitle,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        const Expanded(child: SizedBox()),
                        ...List.generate(
                          deletedTodos[index].urgentLevel,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                        ...List.generate(
                          5 - deletedTodos[index].urgentLevel,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Description:"),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            deletedTodos[index].todoDescription,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            MyUpdateButton(
                              urgentLevel: deletedTodos[index].urgentLevel,
                              categorySelectedIndex:
                                  deletedTodos[index].categoryId,
                              title: deletedTodos[index].todoTitle,
                              description: deletedTodos[index].todoDescription,
                              listenerCallBack: (bool value) {
                                if (true) {
                                  _init();
                                }
                              },
                              id: deletedTodos[index].id!,
                            );
                          },
                          child: Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.edit,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Update")
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext con) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Rostdan ham o'chirmoqchimisiz?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel")),
                                      TextButton(
                                          onPressed: () async {
                                            await LocalDatabase
                                                .deleteCachedTodoById(toDO.id!);
                                            _init();
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok")),
                                    ],
                                  );
                                });
                          },
                          child: Expanded(
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Delete")
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
/*
MyUpdateButton(
                    urgentLevel: deletedTodos[index].urgentLevel,
                    categorySelectedIndex: deletedTodos[index].categoryId,
                    title: deletedTodos[index].todoTitle,
                    description: deletedTodos[index].todoDescription,
                    listenerCallBack: (bool value) {
                      if(true){
                        _init();
                      }
                    },
                    id: deletedTodos[index].id!,
                  );




BasketItem(
                cachedTodo: deletedTodos[index],
                onDeleteTapped: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext con) {
                        return AlertDialog(
                          title: const Text("Rostdan ham o'chirmoqchimisiz?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () async {
                                  await LocalDatabase.deleteCachedTodoById(
                                      toDO.id!);
                                  _init();
                                  Navigator.pop(context);
                                },
                                child: Text("Ok")),
                          ],
                        );
                      });
                },
                onUpdateTapped: () async {
                  MyUpdateButton(
                    urgentLevel: deletedTodos[index].urgentLevel,
                    categorySelectedIndex: deletedTodos[index].categoryId,
                    title: deletedTodos[index].todoTitle,
                    description: deletedTodos[index].todoDescription,
                    listenerCallBack: (bool value) {
                      if(true){
                        _init();
                      }
                    },
                    id: deletedTodos[index].id!,
                  );
                },
              );
 */
