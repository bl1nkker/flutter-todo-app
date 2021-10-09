import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ToDosDatabase {
  static final ToDosDatabase instance = ToDosDatabase._init();

  static Database? _database;

  ToDosDatabase._init();

  // Getter
  Future<Database> get database async {
    // If database exists on the device, returns database
    if (_database != null) return _database!;
    // Else creates one
    _database = await _initDB("todos.db");
    return _database!;
  }

  // Opens database
  Future<Database> _initDB(String filePath) async {
    // Finds path, where all databases stored on Device
    final dbPath = await getDatabasesPath();
    // Creates string that stores path to DB file. Ex: data/data//databases + todos.db
    final path = join(dbPath, filePath);
    // Creates file, where our new database will be stored
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Creates Database table on device. Only executes, if the device has no database files
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const booleanType = 'BOOLEAN NOT NULL';
    // Creating table
    await db.execute('''
    CREATE TABLE $tableTodos(
      ${ToDoFields.id} $idType,
      ${ToDoFields.description} $textType,
      ${ToDoFields.isCompleted} $booleanType,
      ${ToDoFields.deadlineTime} $textType,
      ${ToDoFields.createdTime} $textType,
    )
    ''');
  }

  // CRUD Operations
  Future<ToDo> create(ToDo todo) async {
    // First step: find database to store
    final db = await instance.database;
    // Second step: call the insert method and pass 2 params: in what table we want to store, what we want to store(JSON)
    final id = await db.insert(tableTodos, todo.toJson());
    // Last step: call the copy method and modify the instance
    return todo.copy(id: id);
  }

  // Read one single todo
  Future<ToDo> readOne(int id) async {
    // First step: find database to store
    final db = await instance.database;

    final maps = await db.query(tableTodos,
        columns: ToDoFields.values, where: "${ToDoFields.id} = ?",
        // Against SQL injections
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return ToDo.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not exists');
    }
  }

  // Read all todos
  Future<List<ToDo>> readAll() async {
    // First step: find database to store
    final db = await instance.database;
    // Ordering be creation time, ascending
    final orderBy = '${ToDoFields.createdTime} ASC';
    final result = await db.query(tableTodos, orderBy: orderBy);
    return result.map((jsonTodo) => ToDo.fromJson(jsonTodo)).toList();
  }

  // Update
  Future<int> update(ToDo todo) async {
    final db = await instance.database;

    // Update method takes table, new todo and options
    return db.update(tableTodos, todo.toJson(), where: '${ToDoFields.id} = ?',
        // Against SQL injections
        whereArgs: [todo.id]);
  }

  // Delete
  Future<int> delete(int todo_id) async {
    final db = await instance.database;

    return db.delete(tableTodos, where: '${ToDoFields.id} = ?',
        // Against SQL injections
        whereArgs: [todo_id]);
  }

  // Closes database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
