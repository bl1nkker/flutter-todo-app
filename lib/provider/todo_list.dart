import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter_todo_app/db/models/todo.dart';
import 'package:flutter_todo_app/db/todo_database.dart';

class ToDoModel extends ChangeNotifier {
  /// Internal, private state of the list.
  late List<ToDo> _todos = [];

  /// An unmodifiable view of the items in the list.
  UnmodifiableListView<ToDo> get todos => UnmodifiableListView(_todos);

  void retrieveToDos() async {
    _todos = await ToDosDatabase.instance.readAll();
    notifyListeners();
  }

  void update(ToDo updatedTodo) async {
    await ToDosDatabase.instance.update(updatedTodo);
    _todos = [
      ..._todos.map((todo) => todo.id == updatedTodo.id ? updatedTodo : todo)
    ];
    print('Updated');
    notifyListeners();
  }

  void delete(int todoId) async {
    await ToDosDatabase.instance.delete(todoId);
    notifyListeners();
  }

  /// Adds [todo] to list. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(ToDo todo) async {
    await ToDosDatabase.instance.create(todo);
    _todos.add(todo);
    print('Created');
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _todos.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
