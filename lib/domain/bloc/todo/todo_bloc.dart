import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manabie_todoapp/data/todo.dart';
import 'package:manabie_todoapp/domain/bloc/bloc.dart';
import 'package:manabie_todoapp/objectbox.g.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<TodoFetchEvent>(_onFetch);
  }

  void _onFetch(TodoFetchEvent event, Emitter<TodoState> emit) {
    emit(TodoLoading());
    final queryNullText = event.objectBox.todoBox
        .query(Todo_.status.contains(event.status))
        .build();
    List<Todo> todos = queryNullText.find();
    emit(TodoFetchSuccess(todos));
  }
}
