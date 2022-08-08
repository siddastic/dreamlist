import 'package:dreamlist/constants/db.dart';
import 'package:dreamlist/models/todo.dart';
import 'package:flutter/material.dart' show ChangeNotifier;

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  bool _isTodosLoaded = false;

  bool get isTodosLoaded => _isTodosLoaded;

  void loadTodos() {
    _todos.clear();
    DBRefs.todosCollection.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        _todos.add(Todo.fromJson({
          ...doc.data(),
          'id': doc.id,
        }));
      }
      _isTodosLoaded = true;
      notifyListeners();
    });
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    DBRefs.todosCollection.doc(todo.id).set(todo.toJson());
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    DBRefs.todosCollection.doc(todo.id).delete();
    notifyListeners();
  }
}
