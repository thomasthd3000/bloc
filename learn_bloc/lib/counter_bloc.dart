import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/counter_event.dart';
import 'package:learn_bloc/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(number: 0)) {
    on<OnCounterIncrement>((event, emit) {
      emit(CounterIncrement(number: state.number + 1));
    });

    on<OnCounterDecrement>((event, emit) {
      emit(CounterDecrement(number: state.number - 1));
    });
  }
}
