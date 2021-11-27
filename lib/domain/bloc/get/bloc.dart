import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/data/provider/todo_provider.dart';
import 'package:manabie_todoapp/data/todo.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitialState()) {
    on<TodoFetchEvent>(_onFetch);
    on<TodoUpdateEvent>(_onUpdate);
  }
  void _onFetch(TodoFetchEvent event, Emitter<TodoState> emit) {
    try {
      emit(TodoLoading());
      final TodoProvider todoProvider = new TodoProvider(event.objectBox);
      List<Todo> todos = todoProvider.fetchTodo(event.status);
      emit(TodoFetchSuccess(todos));
    } catch (e) {
      emit(TodoFetchError());
    }
  }

  void _onUpdate(TodoUpdateEvent event, Emitter<TodoState> emit) {
    try {
      emit(TodoLoading());
      Todo? todo = event.todo;
      if (todo != null) {
        final TodoProvider todoProvider = new TodoProvider(event.objectBox);
        Todo newTodo = todo;
        newTodo.status == 'Complete'
            ? newTodo.status = 'Incomplete'
            : newTodo.status = 'Complete';
        todoProvider.updateTodo(todo);
        List<Todo> todos = todoProvider.fetchTodo('');
        emit(TodoFetchSuccess(todos));
      } else {
        emit(TodoUpdateFailure());
      }
    } catch (e) {
      emit(TodoFetchError());
    }
  }
}
