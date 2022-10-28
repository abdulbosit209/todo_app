import 'package:flutter/material.dart';
import 'package:todo_app/presentation/tabs/todo_list/widgets/todo_item.dart';
import '../../../data/db/cached_category.dart';
import '../../../data/db/catched_todos.dart';
import '../../../data/db/local_database.dart';



class MyToDoList extends StatefulWidget {
  const MyToDoList({Key? key}) : super(key: key);

  @override
  State<MyToDoList> createState() => _MyBasketState();
}

class _MyBasketState extends State<MyToDoList> {

  List<CachedCategory> categories = [];
  List<CachedTodo> cachedUsers = [];
  int isDone = 0;

  Future<void> _init() async {
    cachedUsers = (await LocalDatabase.getAllCachedTodo())!.where((element) => element.isDone == 0).toList();
    categories = await LocalDatabase.getAllCachedCategories();
    setState(() {});
  }



  @override
  void initState() {
    _init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyToDoList"),
        ),
        body: RefreshIndicator(
          onRefresh: ()async{
            _init();
          },
          child: ListView(
            children: List.generate(cachedUsers.length, (index) {
              var todo = cachedUsers[index];
              var category = getCategory(categories, todo.categoryId);
              return MyTodosItem(todo: todo, category: category, onTap: ()async{
                isDone = 0;
                await LocalDatabase.updateCachedTodoStatus(todo.id!, 1);
                await _init();
                setState(() {});
              }, isDone: isDone, index: index, deleteTab: () async {
                await LocalDatabase.deleteCachedTodoById(todo.id!);
                await _init();
                setState((){});
              },);
            }
            ),
          ),
        )

    );
  }
} CachedCategory getCategory(List<CachedCategory> categories, int categoryId) {
   return categories
       .where((element) => element.id == categoryId)
       .toList()[0];
}
