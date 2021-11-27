import 'package:equatable/equatable.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/data/helper.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class TodoFetchEvent extends TodoEvent {
  TodoFetchEvent({required this.status, required this.objectBox});
  final String status;
  final ObjectBox objectBox;
}

class TodoUpdateEvent extends TodoEvent {
  TodoUpdateEvent({
    required this.todo,
    required this.objectBox,
    required this.indexPage,
  });
  final Todo? todo;
  final ObjectBox objectBox;
  final int indexPage;
}
