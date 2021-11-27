import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/objectbox.g.dart';

class TodoProvider {
  TodoProvider(this.objectBox);
  final ObjectBox objectBox;

  List<Todo> fetchTodo(String status) {
    final queryNullText =
        objectBox.todoBox.query(Todo_.status.contains(status)).build();
    return queryNullText.find();
  }

  void updateTodo(Todo todo) {
    objectBox.todoBox.put(todo);
  }

  Todo? find(int id) {
    return objectBox.todoBox.get(id);
  }
}
