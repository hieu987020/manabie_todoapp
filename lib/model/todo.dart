import 'dart:developer';

import 'package:manabie_todoapp/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  int id = 0;
  String name;
  String? detail;
  String status;

  Todo({required this.name, this.detail, this.status = "Incomplete"});
}

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {
    final box = store.box<Todo>();
    final id =
        box.put(Todo(name: "Hello world", detail: "This is how we hello"));
    log('id is $id');
    String? result = box.get(id)?.name;
    log(result ?? 'nothing');
    // Add any additional setup code, e.g. build queries.
  }

  ObjectBox._viewAll(this.store) {
    final box = store.box<Todo>();
    final id =
        box.put(Todo(name: "Hello world", detail: "This is how we hello"));
    log('id is $id');
    String? result = box.get(id)?.name;
    log(result ?? 'nothing');
  }
  static Future<void> view() async {
    final store = await openStore();
    final box = store.box<Todo>();
    List<Todo> result = box.getAll();
    log(result.toString());
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
