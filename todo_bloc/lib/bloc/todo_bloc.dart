import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {
    on<OnAddTodo>(addTodo);

    updateTodo();

    on<OnRemoveTodo>((event, emit) {
      int index = event.index;
      List<Todo> todosRemoved = state.todos;
      todosRemoved.removeAt(index);
      emit(TodoRemoved(todosRemoved));
    });
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState> emit) async {
    // Todo newTodo = event.newTodo;
    // List<Todo> oldtodos = state.todos;
    // oldtodos.add(newTodo);
    // emit(TodoAdded(oldtodos));

    emit(TodoLoading(state.todos));
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(TodoAdded([...state.todos, event.newTodo]));
  }

  void updateTodo() {
    return on<OnUpdateTodo>((event, emit) {
      int index = event.index;
      Todo newTodo = event.newTodo;
      List<Todo> todosUpdated = state.todos;
      todosUpdated[index] = newTodo;
      emit(TodoUpdated(todosUpdated));
    });
  }
}
