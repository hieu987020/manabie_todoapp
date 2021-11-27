import 'package:manabie_todoapp/data/provider/todo_provider.dart';
import 'package:manabie_todoapp/domain/bloc/create/event.dart';
import 'package:manabie_todoapp/domain/bloc/create/state.dart';
import 'package:manabie_todoapp/domain/domains.dart';

class TodoCreateBloc extends Bloc<TodoCreateEvent, TodoCreateState> {
  TodoCreateBloc() : super(TodoCreateInitialState()) {
    on<TodoCreateSubmitEvent>(_onSubmit);
  }
  void _onSubmit(TodoCreateSubmitEvent event, Emitter emit) async {
    try {
      emit(TodoCreateLoading());
      final TodoProvider provider = new TodoProvider(event.objectBox);
      provider.putTodo(event.todo);
      emit(TodoCreateLoaded());
      await Future.delayed(Duration(seconds: 1));
      emit(TodoCreateShowNotification());
    } catch (e) {
      emit(TodoCreateError());
    }
  }
}
