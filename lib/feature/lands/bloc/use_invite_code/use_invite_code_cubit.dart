import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:meta/meta.dart';

part 'use_invite_code_state.dart';

class UseInviteCodeCubit extends Cubit<UseInviteCodeState> {
  final LandsRepository landsRepository;

  UseInviteCodeCubit(this.landsRepository) : super(UseInviteCodeInitial());

  void useInviteCode(String code) async {
    emit(UseInviteCodeLoading());
    try {
      await landsRepository.useInviteCode(code);

      emit(UseInviteCodeSuccess());
    } catch (e) {
      emit(UseInviteCodeFailure());
    }
  }
}
