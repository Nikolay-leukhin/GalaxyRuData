part of 'game_cubit.dart';

@immutable
sealed class GameState {}

final class GameInitial extends GameState {}

final class GameScoreIncreased extends GameState {}

