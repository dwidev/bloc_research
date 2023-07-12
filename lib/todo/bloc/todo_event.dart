part of 'todo_bloc.dart';

sealed class TodoEvent {
  const TodoEvent();
}

final class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo(this.todo);
}

final class DeleteTodoEvent extends TodoEvent {
  final String idTodo;
  const DeleteTodoEvent(this.idTodo);
}

final class UpdateTodo extends TodoEvent {
  final Todo todo;

  UpdateTodo(this.todo);
}
