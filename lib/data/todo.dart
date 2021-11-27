import 'package:manabie_todoapp/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  int id = 0;
  String name;
  String? detail;
  String status;
  @Property(type: PropertyType.date)
  DateTime date = DateTime.now();
  Todo({required this.name, this.detail, this.status = "Incomplete"});
}
