class ToDoModel {
  ToDoModel({
    required this.categoryId,
    required this.dateTime,
    required this.isDone,
    required this.todoDescription,
    required this.todoTitle,
    required this.urgentLevel
  });

  String todoTitle;
  String todoDescription;
  int categoryId;
  int isDone;
  String dateTime;
  int urgentLevel;
}
