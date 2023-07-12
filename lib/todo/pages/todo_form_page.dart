import 'package:bloc_research/todo/data/model/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/todo_bloc.dart';

class TodoFormPage extends StatefulWidget {
  final Todo? intialTodo;

  const TodoFormPage({
    Key? key,
    this.intialTodo,
  }) : super(key: key);

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  late TextEditingController todoController;
  late TextEditingController descController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    todoController = TextEditingController();
    descController = TextEditingController();
    if (widget.intialTodo != null) {
      todoController.text = widget.intialTodo?.task ?? "";
      descController.text = widget.intialTodo?.desc ?? "";
    }

    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    todoController.dispose();
    descController.dispose();
    super.dispose();
  }

  void _onCreateTodo() {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    /// update todo
    if (widget.intialTodo != null) {
      final todo = Todo(
        id: widget.intialTodo!.id,
        task: todoController.text,
        desc: descController.text,
      );

      context.read<TodoBloc>().add(UpdateTodo(todo));
      return;
    }

    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      task: todoController.text,
      desc: descController.text,
    );

    context.read<TodoBloc>().add(AddTodo(todo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("bloc test"),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.submitTodoStatus == SubmitTodoStatus.success) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: todoController,
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukan Title";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: descController,
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Masukan deskripsi";
                    }

                    return null;
                  },
                ),
                //
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _onCreateTodo,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
