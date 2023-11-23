part of 'connect_land_cubit.dart';

@immutable
sealed class ConnectLandState {}

final class ConnectLandInitial extends ConnectLandState {}

final class ConnectLandLoading extends ConnectLandState {}

final class ConnectLandSuccess extends ConnectLandState {}

final class ConnectLandFailure extends ConnectLandState {}

