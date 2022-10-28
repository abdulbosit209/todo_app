
import 'package:flutter/material.dart';
import 'package:todo_app/data/db/cached_category.dart';
import '../../../../data/db/catched_todos.dart';
import '../../../../data/db/local_database.dart';


class MyTodosItem extends StatefulWidget {
   MyTodosItem({Key, required this.todo, required this.category, required this.onTap, required this.isDone, required this.index, key, required this.deleteTab}) : super(key: key);


  final CachedTodo todo;
  final CachedCategory category;
  final VoidCallback onTap;
  final VoidCallback deleteTab;
  final int isDone;
  final int index;

  @override
  State<MyTodosItem> createState() => _MyTodosItemState();
}

class _MyTodosItemState extends State<MyTodosItem> {
  List<CachedCategory> categories = [];

  Future<void> init() async {
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
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
          color: const Color(0xFF363636),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(blurRadius: 4,
                spreadRadius: 4,
                offset: const Offset(1, 3),
                color: Colors.grey.shade300)
          ]
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.todo.todoTitle, style: const TextStyle(fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),),
              const Expanded(child: SizedBox()),
              ...List.generate(5 - widget.todo.urgentLevel, (index) => const Icon(Icons.star, color: Colors.grey,)),
              ...List.generate(widget.todo.urgentLevel, (index) => const Icon(Icons.star, color: Colors.yellow,))
            ],
          ),
          const SizedBox(height: 12,),


          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Description: ", style: TextStyle(color: Colors.white),),
              Expanded(child: Text(widget.todo.todoDescription, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14,  color: Colors.white),))
            ],
          ),


          const SizedBox(height: 10,),
          Row(
            children: [
              const Text("category", style: TextStyle(color: Colors.white),),
              const SizedBox(width: 12),
              Text(widget.category.categoryName, style: const TextStyle(color: Colors.white),),
              const Expanded(child: SizedBox()),
              // Icon(category.iconPath, color: Colors.white,),
            Icon(IconData(categories[widget.index].iconPath, fontFamily: 'MaterialIcons')),
            ],
          ),


          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("deadline:", style: TextStyle(color: Colors.white),),
              Text(widget.todo.dateTime, style: const TextStyle(color: Colors.white)),
            ],
          ),


          TextButton(
              onPressed: widget.onTap,
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Finished:"),
                    Checkbox(value: widget.isDone == 0 ? false : true, onChanged: (v) {})
                  ],
                ),
              ),
            ),

          IconButton(onPressed: widget.deleteTab, icon: Icon(Icons.delete))

        ],
      ),
    );
  }
}
