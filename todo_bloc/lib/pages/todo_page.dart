import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo.dart';
import 'package:todo_bloc/widgets/simple_input.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  addTodo() {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              onTap: () {
                Todo newTodo = Todo(edtTitle.text, edtDescription.text);
                context.read<TodoBloc>().add(OnAddTodo(newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Added');
              },
              actionTitle: 'Add Todo',
            )
          ],
        );
      },
    );
  }

  updateTodo(int index, Todo todo) {
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();
    edtTitle.text = todo.title;
    edtDescription.text = todo.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(20),
          children: [
            SimpleInput(
              edtTitle: edtTitle,
              edtDescription: edtDescription,
              onTap: () {
                Todo newTodo = Todo(edtTitle.text, edtDescription.text);
                context.read<TodoBloc>().add(OnUpdateTodo(index, newTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(context, 'Todo Updated');
              },
              actionTitle: 'Update Todo',
            )
          ],
        );
      },
    );
  }

  removeTodo(int index) {
    DInfo.dialogConfirmation(context, 'Remove Todo', 'Are You Sure To Remove this Todo?').then((bool? yes) {
      if (yes ?? false) {
        context.read<TodoBloc>().add(OnRemoveTodo(index));
        Navigator.pop(context);
        DInfo.snackBarSuccess(context, 'Todo Removed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Page'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state is TodoInitial) {
          return const SizedBox.shrink();
        }

        if (state is TodoLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        List<Todo> list = state.todos;

        return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              Todo todo = list[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'update':
                        updateTodo(index, todo);
                        break;
                      case 'remove':
                        removeTodo(index);
                        break;
                      default:
                        DInfo.snackBarError(context, 'Invalid Menu ');
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'update',
                      child: Text('Update'),
                    ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Text('Remove'),
                    )
                  ],
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
