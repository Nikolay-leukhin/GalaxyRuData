import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:meta/meta.dart';

part 'invite_codes_state.dart';

class InviteCodesCubit extends Cubit<InviteCodesState> {
  final LandsRepository landsRepository;

  InviteCodesCubit(this.landsRepository) : super(UseInviteCodeInitial());

  void useInviteCode(String code, Duration animationDuration) async {
    emit(LoadingState());
    try {
      await landsRepository.useInviteCode(code);
      emit(UseInviteCodeSuccess());
      await Future.delayed(animationDuration);
      landsRepository.codeUsed();
    } catch (e) {
      emit(UseInviteCodeFail(e as Exception));
    }
  }

  void connectLandToCurrentCode(String clusterType) async {
    emit(LoadingState());

    try {
      await landsRepository.connectLandFromClusterToCurrentCode(clusterType);

      emit(ConnectLandSuccess());
    } catch (ex) {
      print(ex);
      emit(ConnectLandFail());
    }
  }

  void verifyCurrentCode(String approveCode) async {
    emit(LoadingState());
    try {
      await landsRepository.verifyInviteCode(approveCode);
      emit(SafeSuccess());
    } catch (e) {
      emit(SafeFail());
      rethrow;
    }
  }
}
