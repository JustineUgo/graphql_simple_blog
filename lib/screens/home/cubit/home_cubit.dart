import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/queries.dart';
import 'package:simple_blog/screens/home/cubit/home_state.dart';
import 'package:simple_blog/services/graphql_service.dart';

@singleton
class HomeCubit extends Cubit<HomeState> {
  final BlogGraphqlClient client;
  HomeCubit(this.client) : super(const HomeInitialState());
}
