import 'package:flutter/material.dart';
import 'package:todo_app/data/db/cached_category.dart';
import 'package:todo_app/data/db/local_database.dart';
import 'package:todo_app/data/storage/storage_name.dart';
import '../models/category_model.dart';
import '../models/todo_model.dart';

class MyRepository {
  static final MyRepository _instance = MyRepository._();

  factory MyRepository() {
    return _instance;
  }

  MyRepository._();

  static Future<void> getInitialValue() async {
    await StorageRepository.putBool("isInitial", true);
    await LocalDatabase.insertCachedCategory(CachedCategory(
        iconPath: Icons.work.codePoint,
        //Icon(IconData(categories[index].iconPath, fontFamily: 'MaterialIcons'));
        categoryName: "Work",
        categoryColor: 0xFF00F700));
    await LocalDatabase.insertCachedCategory(CachedCategory(
        iconPath: Icons.sports_basketball.codePoint,
        categoryName: "Sport",
        categoryColor: 0xFF0000F7));
    await LocalDatabase.insertCachedCategory(CachedCategory(
        iconPath: Icons.favorite_outlined.codePoint,

        categoryName: "Health",
        categoryColor: 0xFFF70000));
    await LocalDatabase.insertCachedCategory(CachedCategory(
        iconPath: Icons.fastfood.codePoint,
        categoryName: "Food",
        categoryColor: 0xFFF5E749));
    await LocalDatabase.insertCachedCategory(CachedCategory(
        iconPath: Icons.code.codePoint,
        categoryName: "Coding",
        categoryColor: 0xFF404040));
  }

  static List<ToDoModel> todos = [
    ToDoModel(
        categoryId: 5,
        dateTime: "24/07/2022",
        isDone: 0,
        todoDescription:
        "Learning SQL database requests, Yaxshilab o'rganishim kerak, darsga tayyorlanib borishim shart, Men ikkichi emasman!",
        todoTitle: "SQL",
        urgentLevel: 4,
    ),
    ToDoModel(
      categoryId: 1,
      dateTime: "26/07/2022",
      isDone: 1,
      todoDescription: "Mettingda qatnashishim kerak",
      todoTitle: "Work",
      urgentLevel: 3,
    ),
  ];

  static void addToDoToDone(ToDoModel toDoModel){
    for(int i = 0; i < todos.length; i++){
      if(todos[i] == toDoModel){
        todos[i].isDone = 1;
      }
    }
  }
  static void addNewTodo({required ToDoModel todoModel}) {
    todos.add(todoModel);
  }
}
