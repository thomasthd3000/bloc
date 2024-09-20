import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'live_game_event.dart';
part 'live_game_state.dart';

class LiveGameBloc extends Bloc<LiveGameEvent, LiveGameState> {
  LiveGameBloc() : super(LiveGameInitial()) {
    on<LiveGameEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
