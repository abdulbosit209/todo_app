import 'package:flutter/material.dart';
import 'package:todo_app/data/db/cached_category.dart';

import '../../../data/db/catched_todos.dart';
import '../../../data/db/local_database.dart';
import '../../../data/my_repository.dart';
import '../todo_list/todo_screen.dart';
import '../todo_list/widgets/todo_item.dart';

class MyDoneList extends StatefulWidget {
  const MyDoneList({Key? key}) : super(key: key);

  @override
  State<MyDoneList> createState() => _MyBasketState();
}

class _MyBasketState extends State<MyDoneList> {

  List<CachedCategory> categories = [];
  List<CachedTodo> cachedUsers = [];
  bool? isDone;

  Future<void> init()async{
    cachedUsers = (await LocalDatabase.getAllCachedTodo())!.where((element) => element.isDone == 1).toList();
    categories = await LocalDatabase.getAllCachedCategories();
    setState((){});
  }


  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyToDoList"),
        ),
        body:RefreshIndicator(
          onRefresh: ()async{
            init();
          },
          child: ListView(
            children: List.generate(cachedUsers.length, (index) {
              var todo = cachedUsers[index];
              var category = getCategory(categories, todo.categoryId);
              return MyTodosItem(todo: todo, category: category, onTap: (){}, isDone: 1, index: index, deleteTab: () async {
                await LocalDatabase.updateCachedTodoStatus(todo.id!, 2);
                await init();
                setState((){});
              },);
            }
            ),
          ),
        )
    );
  }
}
/*
ListView(
            children: List.generate(cachedUsers.length, (index) {
              var todo = cachedUsers[index];
              var category = getCategory(categories, todo.categoryId);
              return MyTodosItem(todo: todo, category: category, onTap: (){}, isDone: 1, index: index, deleteTab: () async {
                await LocalDatabase.updateCachedTodoStatus(todo.id!, 2);
                await init();
                setState((){});
              },);
            }
            ),
          ),
 */
