import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'cached_category.dart';
import 'catched_todos.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._();
  static Database? _database;

  factory LocalDatabase() {
    return getInstance;
  }

  LocalDatabase._();

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDB("todos.db");
      return _database;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _creatDB);
  }

  Future _creatDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";

    await db.execute('''
      CREATE TABLE $myTableName (
      ${CachesTodoField.id} $idType,
      ${CachesTodoField.categoryId} $intType,
      ${CachesTodoField.dateTime} $textType,
      ${CachesTodoField.isDone} $intType,
      ${CachesTodoField.todoDescription} $textType,
      ${CachesTodoField.todoTitle} $textType,
      ${CachesTodoField.urgentLevel} $intType
      )
    ''');


    await db.execute('''
    CREATE TABLE $categoryTable (
    ${CachedCategoryFields.id} $idType,
    ${CachedCategoryFields.categoryName} $textType,
    ${CachedCategoryFields.iconPath} $intType,
    ${CachedCategoryFields.categoryColor} $intType
    )
    ''');

  }

  static Future<CachedTodo> insertCachedTodo(CachedTodo catchesTodo) async {
    final db = await getInstance.database;
    final id = await db?.insert(myTableName, catchesTodo.toJson());
    return catchesTodo.copyWith(id: id);
  }

  static Future<List<CachedTodo>?> getAllCachedTodo() async {
    final db = await getInstance.database;
    const orderBy = "${CachesTodoField.todoTitle} ASC";

    final result = await db?.query(myTableName, orderBy: orderBy);
    return result?.map((json) => CachedTodo.fromJson(json)).toList();
  }

  static Future<int?> deleteAllCachedTodos() async {
    final db = await getInstance.database;
    return await db?.delete(myTableName);
  }

  static Future<int> deleteCachedTodoById(int id) async {
    final db = await getInstance.database;
    var t = await db?.delete(myTableName,
        where: "${CachesTodoField.id}=?", whereArgs: [id]);
    if (t! > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<Future<int>?> updateCachedTodoStatus(int id, int status) async {
    Map<String, dynamic> row = {
      CachesTodoField.isDone: status,
    };
    final db = await getInstance.database;
    return db!.update(
      myTableName,
      row,
      where: '${CachesTodoField.id} = ?',
      whereArgs: [id],
    );
  }

    static Future<Future<int>?> updateCachedTodo({required int id, required CachedTodo cachedTodo} ) async {
      Map<String, dynamic> row = {
        CachesTodoField.isDone: cachedTodo.isDone,
        CachesTodoField.todoDescription: cachedTodo.todoDescription,
        CachesTodoField.todoTitle: cachedTodo.todoTitle,
        CachesTodoField.urgentLevel: cachedTodo.urgentLevel,
        CachesTodoField.dateTime: cachedTodo.dateTime,
        CachesTodoField.categoryId: cachedTodo.categoryId,
      };
        final db = await getInstance.database;
        return db!.update(
          myTableName,
          row,
          where: '${CachesTodoField.id} = ?',
          whereArgs: [id],
        );
  }

  Future close() async {
    final db = await getInstance.database;
    db?.close();
  }

  //------------------------------------------------------------------------------------------------

  static Future<CachedCategory> insertCachedCategory(
      CachedCategory cachedCategory) async {
    final db = await getInstance.database;
    final id = await db!.insert(categoryTable, cachedCategory.toJson());
    return cachedCategory.copyWith(id: id);
  }

  static Future<CachedCategory> getSingleCategoryById(int id) async {
    final db = await getInstance.database;
    final results = await db!.query(
      categoryTable,
      columns: CachedCategoryFields.values,
      where: '${CachedCategoryFields.id} = ?',
      whereArgs: [id],
    );
    if (results.isNotEmpty) {
      return CachedCategory.fromJson(results.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<List<CachedCategory>> getAllCachedCategories() async {
    final db = await getInstance.database;
    final result = await db!.query(
      categoryTable,
    );
    return result.map((json) => CachedCategory.fromJson(json)).toList();
  }

  static Future<int> deleteCachedCategoryById(int id) async {
    final db = await getInstance.database;
    var t = await db!.delete(categoryTable,
        where: "${CachedCategoryFields.id}=?", whereArgs: [id]);
    if (t > 0) {
      return t;
    } else {
      return -1;
    }
  }

  static Future<int> updateCachedCategory(
      {required int id, required CachedCategory cachedCategory}) async {
    Map<String, dynamic> row = {
      CachedCategoryFields.iconPath: cachedCategory.iconPath,
      CachedCategoryFields.categoryColor: cachedCategory.categoryColor,
      CachedCategoryFields.categoryName: cachedCategory.categoryName,
    };

    final db = await getInstance.database;
    return await db!.update(
      categoryTable,
      row,
      where: '${CachedCategoryFields.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAllCachedCategories() async {
    final db = await getInstance.database;
    return await db!.delete(categoryTable);
  }

}
