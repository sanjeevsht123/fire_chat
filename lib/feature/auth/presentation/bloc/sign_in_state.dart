import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Added for UserCredential

part 'sign_in_state.freezed.dart';  // Added: Required for Freezed generation

@freezed
class SignInState with _$SignInState {
 const factory SignInState.initial() = _Initial;
 const factory SignInState.loading() = _Loading;
 const factory SignInState.success(UserCredential userInfo) = _Success;
 const factory SignInState.error(String error) = _Error;
}