import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';
@freezed
class SignUpState with _$SignUpState{
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = _Loading;
  const factory SignUpState.success(UserCredential userInfo) = _Success;
  const factory SignUpState.error(String error) = _Error;
}