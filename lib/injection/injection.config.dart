// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:graphql_flutter/graphql_flutter.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:simple_blog/injection/module/service_module.dart' as _i8;
import 'package:simple_blog/screens/home/cubit/home_cubit.dart' as _i7;
import 'package:simple_blog/services/graphql_service.dart' as _i5;
import 'package:simple_blog/services/toast_service.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final serviceModule = _$ServiceModule();
    gh.factory<_i3.ValueNotifier<_i4.GraphQLClient>>(
        () => serviceModule.client);
    gh.singleton<_i5.BlogGraphqlClient>(() => _i5.BlogGraphqlClientImpl());
    gh.singleton<_i6.Toast>(() => _i6.Toastify());
    gh.singleton<_i7.HomeCubit>(
        () => _i7.HomeCubit(gh<_i5.BlogGraphqlClient>()));
    return this;
  }
}

class _$ServiceModule extends _i8.ServiceModule {}
