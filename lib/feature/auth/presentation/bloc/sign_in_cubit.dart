import 'package:fire/feature/auth/domain/repository/auth_repository.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

// Kept: Includes the state definition

// Removed: part 'sign_in_state.freezed.dart'; (redundant, belongs in state file)
// Removed: part 'sign_in_cubit.freezed.dart'; (unnecessary, no @freezed here)

@injectable
class SignInCubit extends Cubit<SignInState> {
 SignInCubit(this._authRepository) : super(SignInState.initial());
 final AuthRepository _authRepository;

 Future<void> signIn({required String email, required String password}) async {
  emit(SignInState.loading());
  emit((await _authRepository.signIn(email: email, password: password)).fold(
          (error) => SignInState.error(error.plugin),
          (data) => SignInState.success(data)));
 }
}