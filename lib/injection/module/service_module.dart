
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServiceModule {

  @singleton
  final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink('https://uat-api.vmodel.app/graphql/'),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
}
