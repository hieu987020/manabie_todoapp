import 'dart:developer';

import 'package:manabie_todoapp/data/helper.dart';
import 'package:manabie_todoapp/data/todo.dart';
import 'package:objectbox/objectbox.dart';
import 'package:manabie_todoapp/objectbox.g.dart';

late ObjectBox objectbox;
late Box<Todo> todoBox;
late Store store;

class TodoProvider {
  List<Todo>? getComplete() {
    List<Todo>? todos;
    openStore().then((Store store) {
      var _box = store.box<Todo>();
      todos = _box.getAll();
      store.close();
    });
    todos?.forEach((element) {
      log(element.name);
      log(element.detail ?? 'nothing');
      log(element.status);
    });
    return todos;
  }
}
