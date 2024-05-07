
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_blog/models/post.dart';
part 'home_state.freezed.dart';
@freezed
class HomeState with _$HomeState{
  const factory HomeState.initial() = HomeInitialState;
  
  const factory HomeState.loading() = HomeLoadingState;
  
  const factory HomeState.loaded({required List<Post> posts}) = HomeLoadedState;
  
  const factory HomeState.error({dynamic error}) = HomeErrorState;
  
}