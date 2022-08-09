import 'package:dreamlist/constants/db.dart';
import 'package:dreamlist/models/todo.dart';
import 'package:dreamlist/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TodoProvider with ChangeNotifier {
  final List<Todo> _todos = [];
  List<Todo> get todos => _todos;
  bool _isTodosLoaded = false;
  BuildContext? _homeScreenContext;
  LottieComposition? _composition;

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

  void changeTodoStatus(Todo todo) {
    var index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index].isDone = !_todos[index].isDone;
    DBRefs.todosCollection.doc(todo.id).update({
      'isDone': todo.isDone,
    });
    // if all tasks are completed
    if (_todos.every((element) => element.isDone)) {
      showConfettiAnimation();
    }
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    DBRefs.todosCollection.doc(todo.id).set(todo.toJson());
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((element) => element.id == todo.id);
    DBRefs.todosCollection.doc(todo.id).delete();
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    var index = _todos.indexWhere((element) => element.id == todo.id);
    _todos[index] = todo;
    DBRefs.todosCollection.doc(todo.id).update(todo.toJson());
    notifyListeners();
  }

  void attachHomeScreenVariables(
      BuildContext context, LottieComposition? composition) {
    _homeScreenContext = context;
    _composition = composition;
  }

  void showConfettiAnimation() {
    if (_homeScreenContext != null) {
      showDialog(
        barrierColor: Colors.transparent,
        context: _homeScreenContext!,
        builder: (context) {
          return Lottie(
            composition: _composition,
            repeat: false,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        },
      );
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(_homeScreenContext!).popUntil(ModalRoute.withName(HomeScreen.routeName));
      });
    }
  }
}
