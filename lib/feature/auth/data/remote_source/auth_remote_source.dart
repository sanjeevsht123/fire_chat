import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteSource {
  Future<UserCredential> signIn({
    required String email,
    required String password,
  });

  Future<UserCredential> signUp({    required String email,
    required String password,});
}

@LazySingleton(as: AuthRemoteSource)
class AuthRemoteSourceImpl extends AuthRemoteSource {
  AuthRemoteSourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response= await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(response.user != null){
        return response;
      }else{
        throw FirebaseException(plugin: 'Unknown Error Occurred');
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseException(plugin: e.message??'');
    }
  }

  @override
  Future<UserCredential> signUp({required String email, required String password}) async{
    try{
      final response= await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(response.user!=null){
        return response;
      }else{
        throw FirebaseException(plugin: 'Unknown Error Occurred');
      }
    }on FirebaseAuthException catch (e){
      throw FirebaseException(plugin: e.message??'');
    }
  }
}
