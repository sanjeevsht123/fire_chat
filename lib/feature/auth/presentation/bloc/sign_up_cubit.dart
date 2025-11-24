import 'package:fire/feature/auth/domain/repository/auth_repository.dart';
import 'package:fire/feature/auth/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepository) : super(SignUpState.initial());
  final AuthRepository _authRepository;

  Future<void> signUp({required String email, required String passwd}) async {
    emit(SignUpState.loading());
    final response = await _authRepository.signUp(email: email, passwd: passwd);
    emit(
      response.fold(
        (error) => SignUpState.error(error.plugin),
        (success) => SignUpState.success(success),
      ),
    );
  }
}
