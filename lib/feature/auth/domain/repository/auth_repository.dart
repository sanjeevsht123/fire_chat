import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<FirebaseException, UserCredential>> signIn({
    required String email,
    required String password,
  });

  Future<Either<FirebaseException, UserCredential>> signUp({required String email,required String passwd});
}
