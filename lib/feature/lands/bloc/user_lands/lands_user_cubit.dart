import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:meta/meta.dart';

part 'lands_user_state.dart';

class LandsUserCubit extends Cubit<LandsUserState> {
  final LandsRepository landsRepository;

  LandsUserCubit(this.landsRepository) : super(LandsUserInitial()) {
    landsRepository.userLandsStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(LandsUserLoading());
      if (value == LoadingStateEnum.fail) emit(LandsUserFailure());
      if (value == LoadingStateEnum.success) {
        emit(LandsUserSuccess());
      } 
    });
  }
}
