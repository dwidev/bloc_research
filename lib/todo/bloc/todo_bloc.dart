import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import '../data/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdate);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    emit(state.copyWith(
      todos: [...state.todos, event.todo],
      submitTodoStatus: SubmitTodoStatus.success,
    ));
  }

  void _onUpdate(UpdateTodo event, Emitter<TodoState> emit) {
    final updatedTodo = state.todos.toList();
    final indexTodo = updatedTodo.indexWhere((t) => t.id == event.todo.id);
    updatedTodo[indexTodo] = event.todo;

    emit(state.copyWith(
      todos: updatedTodo,
      submitTodoStatus: SubmitTodoStatus.success,
    ));
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) {
    final deletedTodos = state.todos.toList();
    deletedTodos.removeWhere((element) => element.id == event.idTodo);
    emit(state.copyWith(todos: deletedTodos));
  }
}
