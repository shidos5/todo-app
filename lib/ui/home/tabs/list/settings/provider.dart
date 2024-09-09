import 'package:flutter/foundation.dart';
import 'package:todo6/model/todo_dm.dart';

class TodoProvider extends ChangeNotifier {
  // Define your provider's state and methods here
  final List<ToDoDm> _todos = [];

  List<ToDoDm> get todos => _todos;

  get id => null;

  void addTodo(ToDoDm todo) {
    _todos.add(todo);
    notifyListeners();
  }

  // Add other methods to manipulate the list of todos
}
