// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:fire/feature/auth/data/remote_source/auth_remote_source.dart'
    as _i30;
import 'package:fire/feature/auth/data/repository/auth_repository_impl.dart'
    as _i715;
import 'package:fire/feature/auth/domain/repository/auth_repository.dart'
    as _i391;
import 'package:fire/feature/auth/presentation/bloc/sign_in_cubit.dart'
    as _i643;
import 'package:fire/feature/auth/presentation/bloc/sign_up_cubit.dart'
    as _i636;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i30.AuthRemoteSource>(
      () => _i30.AuthRemoteSourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i391.AuthRepository>(
      () => _i715.AuthRepositoryImpl(gh<_i30.AuthRemoteSource>()),
    );
    gh.factory<_i643.SignInCubit>(
      () => _i643.SignInCubit(gh<_i391.AuthRepository>()),
    );
    gh.factory<_i636.SignUpCubit>(
      () => _i636.SignUpCubit(gh<_i391.AuthRepository>()),
    );
    return this;
  }
}
