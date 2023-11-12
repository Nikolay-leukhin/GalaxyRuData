import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'enter_seed_state.dart';

class EnterSeedCubit extends Cubit<EnterSeedState> {
  EnterSeedCubit() : super(EnterSeedInitial());
}
