import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/screens/home/cubit/home_state.dart';
import 'package:simple_blog/services/graphql_service.dart';

@singleton
class HomeCubit extends Cubit<HomeState> {
  final BlogGraphqlClient client;
  HomeCubit(this.client) : super(const HomeInitialState());

  void getBookmarks() {
    Map<String, dynamic>? bookmarks = HiveStore().get('bookmarks');
    if (bookmarks != null) {
      List<Post> bookmarkedPosts = (bookmarks['posts'] as List).map((json) => Post.fromJson(json)).toList();
      emit(HomeBookmarkedState(posts: bookmarkedPosts));
    }
  }

  void bookmark(List<Post> posts, Post post, bool isCurrentlyBooked) {
    if (isCurrentlyBooked) {
      List<Post> bookmarkedPosts = posts.where((element) => element.id != post.id).toList();
      HiveStore().put('bookmarks', {'posts': bookmarkedPosts.map((post) => post.toJson()).toList()});
    } else {
      List<Post> bookmarkedPosts = [...posts, post];
      HiveStore().put('bookmarks', {'posts': bookmarkedPosts.map((post) => post.toJson()).toList()});
    }
    getBookmarks();
  }
}
