
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_blog/models/post.dart';
part 'home_state.freezed.dart';
@freezed
class HomeState with _$HomeState{
  const factory HomeState.initial() = HomeInitialState;
  
  
  const factory HomeState.bookmarked({required List<Post> posts}) = HomeBookmarkedState;
  
  
}