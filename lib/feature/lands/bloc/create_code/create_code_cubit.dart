import 'package:bloc/bloc.dart';
import 'package:galaxy_rudata/feature/lands/data/lands_repository.dart';
import 'package:meta/meta.dart';

part 'create_code_state.dart';

class CreateCodeCubit extends Cubit<CreateCodeState> {
  final LandsRepository landsRepository;

  CreateCodeCubit(this.landsRepository) : super(CreateCodeInitial());

  void loadCode() async {
    emit(CreateCodeLoading());
    await landsRepository.getApprove();
    await Future.delayed(Duration(seconds: 2));
    emit(CreateCodeSuccess());
  }
}
