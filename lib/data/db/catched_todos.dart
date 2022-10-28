const String myTableName = "MyTable";

class CachesTodoField {
  static const String id = "_id";
  static const String categoryId = "category_id";
  static const String dateTime = "date_time";
  static const String isDone = "is_done";
  static const String todoDescription = "todo_description";
  static const String todoTitle = "todo_title";
  static const String urgentLevel = "urgent_level";
}

class CachedTodo {
  final int? id;
  final int categoryId;
  final String dateTime;
  final int isDone;
  final String todoDescription;
  final String todoTitle;
  final int urgentLevel;

  CachedTodo({
    this.id,
    required this.dateTime,
    required this.urgentLevel,
    required this.todoDescription,
    required this.todoTitle,
    required this.isDone,
    required this.categoryId,
  });

  CachedTodo copyWith({
    int? id,
    int? categoryId,
    String? dateTime,
    int? isDone,
    String? todoDescription,
    String? todoTitle,
    int? urgentLevel,
  }) =>
      CachedTodo(
          id: id ?? this.id,
          dateTime: dateTime ?? this.dateTime,
          urgentLevel: urgentLevel ?? this.urgentLevel,
          todoDescription: todoDescription ?? this.todoDescription,
          todoTitle: todoTitle ?? this.todoTitle,
          isDone: isDone ?? this.isDone,
          categoryId: categoryId ?? this.categoryId,
      );


  static CachedTodo fromJson(Map<String, Object?> json){
    return CachedTodo(
      id: json[CachesTodoField.id] as int,
      dateTime: json[CachesTodoField.dateTime] as String,
      urgentLevel: json[CachesTodoField.urgentLevel] as int,
      todoDescription: json[CachesTodoField.todoDescription] as String,
      todoTitle: json[CachesTodoField.todoTitle] as String,
      isDone: json[CachesTodoField.isDone] as int,
      categoryId: json[CachesTodoField.categoryId] as int,
    );
  }

  Map<String, Object?> toJson() => {
    CachesTodoField.id: id,
    CachesTodoField.dateTime: dateTime,
    CachesTodoField.urgentLevel: urgentLevel,
    CachesTodoField.todoDescription: todoDescription,
    CachesTodoField.todoTitle: todoTitle,
    CachesTodoField.isDone: isDone,
    CachesTodoField.categoryId: categoryId,
  };

}
