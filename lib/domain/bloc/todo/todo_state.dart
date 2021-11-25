import 'package:equatable/equatable.dart';
import 'package:manabie_todoapp/data/todo.dart';

abstract class TodoState extends Equatable {}

class TodoInitialState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoFetchSuccess extends TodoState {
  TodoFetchSuccess(this.todos);
  final List<Todo> todos;

  @override
  List<Object?> get props => [];
}

class TodoFetchError extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoLoading extends TodoState {
  @override
  List<Object?> get props => [];
}
