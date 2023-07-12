part of 'todo_bloc.dart';

enum SubmitTodoStatus { intial, success }

@immutable
class TodoState {
  final SubmitTodoStatus submitTodoStatus;
  final List<Todo> todos;

  TodoState({
    required this.submitTodoStatus,
    required this.todos,
  });

  TodoState copyWith({
    String? title,
    SubmitTodoStatus? submitTodoStatus,
    List<Todo>? todos,
  }) {
    return TodoState(
      submitTodoStatus: submitTodoStatus ?? this.submitTodoStatus,
      todos: todos ?? this.todos,
    );
  }

  @override
  bool operator ==(covariant TodoState other) {
    if (identical(this, other)) return true;

    return other.submitTodoStatus == submitTodoStatus &&
        listEquals(other.todos, todos);
  }

  @override
  int get hashCode => submitTodoStatus.hashCode ^ todos.hashCode;

  @override
  String toString() =>
      'TodoState(submitTodoStatus: $submitTodoStatus, todos: $todos)';
}

class TodoInitial extends TodoState {
  TodoInitial()
      : super(
          todos: [],
          submitTodoStatus: SubmitTodoStatus.intial,
        );
}
