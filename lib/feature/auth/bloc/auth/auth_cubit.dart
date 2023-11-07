import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starter/feature/auth/data/auth_repository.dart';
import 'package:starter/utils/utils.dart';

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
        emit(AuthSuccessState(name: _authRepository.user!.name));
      }
    });
  }

  login({required String email, required String password}) async =>
      _authRepository.login(email, password);

  register(
          {required String name,
          required String password,
          required String email}) async =>
      _authRepository.register(name, email, password);
}
