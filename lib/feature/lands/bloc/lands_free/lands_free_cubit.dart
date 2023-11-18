import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/invites_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';
import 'package:meta/meta.dart';

part 'lands_free_state.dart';

class LandsFreeCubit extends Cubit<LandsFreeState> {
  final LandsRepository landsRepository;

  LandsFreeCubit(this.landsRepository) : super(LandsFreeInitial()) {
    landsRepository.freeLandsStream.listen((value) {
      if (value == LoadingStateEnum.loading) emit(LandsFreeLoading());
      if (value == LoadingStateEnum.fail) emit(LandsFreeFailure());
      if (value == LoadingStateEnum.success) {
        emit(LandsFreeSuccess());
      } 
    });
  }
}
