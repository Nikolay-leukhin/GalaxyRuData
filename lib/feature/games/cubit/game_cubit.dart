import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  int counter = 0;

  GameCubit() : super(GameInitial());

  void updateCounter() {
    counter += 1;
    emit(GameScoreIncreased());
  }
}
