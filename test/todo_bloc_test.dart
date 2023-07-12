import 'package:bloc_research/todo/bloc/todo_bloc.dart';
import 'package:bloc_research/todo/data/model/todo_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final todo1 = Todo(id: "id1", task: "task1", desc: "desc1");
  final todo2 = Todo(id: "id2", task: "task2", desc: "desc2");
  final initialTodos = [todo1, todo2];

  late TodoBloc todoBloc;

  setUp(() {
    todoBloc = TodoBloc();
  });

  tearDown(() {
    todoBloc.close();
  });

  group('TodoBloc', () {
    /// Add Test
    blocTest<TodoBloc, TodoState>(
      'emits the correct state when AddTodo event is added',
      build: () => todoBloc,
      act: (bloc) => bloc.add(AddTodo(todo1)),
      expect: () => [
        TodoState(
          todos: [todo1],
          submitTodoStatus: SubmitTodoStatus.success,
        ),
      ],
    );

    /// Update Test
    final updatedTodo = Todo(
      id: "id1",
      task: "task1update",
      desc: "desc1update",
    );

    blocTest<TodoBloc, TodoState>(
      'emits the correct state when UpdateTodo event is added',
      build: () => todoBloc,
      seed: () => TodoState(
        todos: initialTodos,
        submitTodoStatus: SubmitTodoStatus.intial,
      ),
      act: (bloc) => bloc.add(UpdateTodo(updatedTodo)),
      expect: () => [
        TodoState(
          todos: [updatedTodo, todo2],
          submitTodoStatus: SubmitTodoStatus.success,
        ),
      ],
    );

    blocTest<TodoBloc, TodoState>(
      'emits the correct state when DeleteTodoEvent is added',
      build: () => todoBloc,
      seed: () => TodoState(
        todos: initialTodos,
        submitTodoStatus: SubmitTodoStatus.intial,
      ),
      act: (bloc) => bloc.add(DeleteTodoEvent("id1")),
      expect: () => [
        TodoState(
          todos: [todo2],
          submitTodoStatus: SubmitTodoStatus.intial,
        ),
      ],
    );
  });
}
