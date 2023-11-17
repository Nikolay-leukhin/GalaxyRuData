import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:galaxy_rudata/feature/auth/data/auth_repository.dart';
import 'package:galaxy_rudata/utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    _authRepository.authState.stream.listen((event) {
      if (event == LoadingStateEnum.loading) emit(AuthLoadingState());
      if (event == LoadingStateEnum.fail) emit(AuthFailState());
      if (event == LoadingStateEnum.success) {
        emit(AuthSuccessState());
      }
    });
  }

  auth({required String email, required String password}) async =>
      _authRepository.auth(email, password);
}
