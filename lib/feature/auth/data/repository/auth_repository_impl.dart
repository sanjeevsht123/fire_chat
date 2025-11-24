import 'package:dartz/dartz.dart';
import 'package:fire/feature/auth/data/remote_source/auth_remote_source.dart';
import 'package:fire/feature/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this._remoteSource);

  final AuthRemoteSource _remoteSource;

  @override
  Future<Either<FirebaseException, UserCredential>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteSource.signIn(
        email: email,
        password: password,
      );
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, UserCredential>> signUp({required String email, required String passwd}) async {
    try{
      final response= await _remoteSource.signUp(email: email, password: passwd);
      return right(response);
    }on FirebaseException catch(e){
      return left(e);
    }
  }
}
