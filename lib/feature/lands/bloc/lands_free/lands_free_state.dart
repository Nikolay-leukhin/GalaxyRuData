part of 'lands_free_cubit.dart';

@immutable
sealed class LandsFreeState {}

final class LandsFreeInitial extends LandsFreeState {}

final class LandsFreeLoading extends LandsFreeState {}

final class LandsFreeSuccess extends LandsFreeState {}

final class LandsFreeFailure extends LandsFreeState {}

