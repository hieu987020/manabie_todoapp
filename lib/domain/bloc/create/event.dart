import 'package:equatable/equatable.dart';

import 'package:manabie_todoapp/data/data.dart';

abstract class TodoCreateEvent extends Equatable {
  const TodoCreateEvent();
  @override
  List<Object?> get props => [];
}

class TodoCreateSubmitEvent extends TodoCreateEvent {
  TodoCreateSubmitEvent({
    required this.todo,
    required this.objectBox,
  });
  final Todo todo;
  final ObjectBox objectBox;
}
