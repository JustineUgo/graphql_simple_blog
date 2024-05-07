import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/queries.dart';
import 'package:simple_blog/screens/home/widgets/home.dart';
import 'package:simple_blog/theme/theme.dart';

@RoutePage()
class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with GetItStateMixin {
  VoidCallback? refetchCallback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (refetchCallback != null) refetchCallback!();
        },
        child: const Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.baseDouble),
            child: Query(
              options: QueryOptions(
                document: gql(allBlogs),
              ),
              builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
                refetchCallback = refetch;
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (result.data != null) {
                  List data = result.data!['allBlogPosts'] as List;
                  List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
                  posts.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
                  return Home(posts: posts, refetchCallback: refetchCallback);
                } else if (result.hasException) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Unable to display posts due to error.', style: context.textStyle),
                        IconButton(onPressed: refetch, icon: const Icon(Icons.refresh)),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
