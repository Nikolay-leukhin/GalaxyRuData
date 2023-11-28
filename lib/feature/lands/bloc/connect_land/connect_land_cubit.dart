import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
part 'connect_land_state.dart';

class ConnectLandCubit extends Cubit<ConnectLandState> {
  final AuthRepository authRepository;
  final LandsRepository landsRepository;

  ConnectLandCubit(
      {required this.authRepository, required this.landsRepository})
      : super(ConnectLandInitial());

  void connectRandomFromClusterLandToCurrentCode(String clusterType) async {
    emit(ConnectLandLoading());

    try {
      await landsRepository.connectLandFromClusterToCurrentCode(clusterType);

      emit(ConnectLandSuccess());
    } catch (ex) {
      print(ex);
      emit(ConnectLandFailure());
    }
  }
}
