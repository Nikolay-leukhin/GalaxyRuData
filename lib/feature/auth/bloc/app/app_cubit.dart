import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starter/feature/auth/data/auth_repository.dart';
import 'package:starter/utils/utils.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthRepository _authRepository;

  AppCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AppInitial()) {
    _authRepository.appState.stream.listen((event) {
      if (event == AppStateEnum.auth) emit(AppAuthState());
      if (event == AppStateEnum.unAuth) emit(AppUnAuthState());
    });
  }
}
