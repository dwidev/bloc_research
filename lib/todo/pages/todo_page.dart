import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';
import '../data/model/todo_model.dart';
import 'todo_form_page.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({
    Key? key,
  }) : super(key: key);
  void _gotoTodoForm(BuildContext context, {Todo? todo}) {
    final bloc = context.read<TodoBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider.value(
            value: bloc,
            child: TodoFormPage(intialTodo: todo),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILD");

    return Scaffold(
      appBar: AppBar(
        title: const Text("bloc test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final data = state.todos[index];
                      return ListTile(
                        selectedColor: Colors.red,
                        title: Text(data.task),
                        subtitle: Text(data.desc),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _gotoTodoForm(context, todo: data);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<TodoBloc>()
                                      .add(DeleteTodoEvent(data.id));
                                },
                                icon: Icon(Icons.delete),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
            //
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _gotoTodoForm(context),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
