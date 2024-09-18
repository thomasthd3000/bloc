import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  // int _counter = 0;

  // int get counter => _counter;

  increment() {
    int newState = state + 1;
    emit(newState);
  }

  decrement() {
    //int newState = state + 1;
    emit(state - 1);
  }
}
