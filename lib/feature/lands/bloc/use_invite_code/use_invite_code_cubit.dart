import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/invites_repository.dart';
import 'package:meta/meta.dart';

part 'use_invite_code_state.dart';

class UseInviteCodeCubit extends Cubit<UseInviteCodeState> {
  final InvitesRepository invitesRepository;

  UseInviteCodeCubit(this.invitesRepository) : super(UseInviteCodeInitial());

  void useInviteCode(String code) async {
    emit(UseInviteCodeLoading());
    try {
      await invitesRepository.useInviteCode(code);

      emit(UseInviteCodeSuccess());
    } catch (e) {
      emit(UseInviteCodeFailure());
    }
  }
}
