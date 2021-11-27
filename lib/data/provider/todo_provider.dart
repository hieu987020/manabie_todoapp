import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/objectbox.g.dart';

class TodoProvider {
  TodoProvider(this.objectBox);
  final ObjectBox objectBox;

  List<Todo> fetchTodo(String status) {
    final queryNullText = objectBox.todoBox.query(Todo_.status.contains(status))
      ..order(Todo_.date, flags: Order.descending);
    return queryNullText.build().find();
  }

  void putTodo(Todo todo) {
    todo.date = DateTime.now();
    objectBox.todoBox.put(todo);
  }

  Todo? find(int id) {
    return objectBox.todoBox.get(id);
  }
}
