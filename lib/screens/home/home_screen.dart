import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_blog/injection/injection.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/queries.dart';
import 'package:simple_blog/screens/home/cubit/home_cubit.dart';
import 'package:simple_blog/screens/home/cubit/home_state.dart';
import 'package:simple_blog/screens/home/widgets/search_widget.dart';
import 'package:simple_blog/theme/theme.dart';

@RoutePage()
class HomeScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with GetItStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
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
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (result.data != null) {
                  List data = result.data!['allBlogPosts'] as List;
                  List<Post> posts = data.map((json) => Post.fromJson(json)).toList();
                  return Home(posts: posts);
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

class Home extends StatefulWidget {
  Home({super.key, required this.posts});
  final List<Post> posts;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    posts = widget.posts;
  }

  List<Post> posts = [];
  List<Post> bookmarkedPosts = [];
  final PageController pageController = PageController();
  int pageIndex = 0;

  void onQuery(String query) {
    if (query.isNotEmpty) {
      setState(() => posts = widget.posts.where((post) => post.title.toLowerCase().contains(query.toLowerCase())).toList());
    } else {
      setState(() => posts = widget.posts.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          color: const Color(0xff21242C),
          child: Column(
            children: [
              Text("Simple Blog", style: context.textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 20)),
              const SizedBox(height: 20),
              Visibility(
                visible: pageIndex == 0,
                child: Search(onQuery: onQuery),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => pageController.jumpToPage(0),
                      child: Text("All", style: context.textStyle.copyWith(fontWeight: FontWeight.w500, color: pageIndex == 0 ? null : Colors.white54)),
                    ),
                    const SizedBox(width: 30),
                    GestureDetector(
                      onTap: () => pageController.jumpToPage(1),
                      child: Text("Bookmarked", style: context.textStyle.copyWith(fontWeight: FontWeight.w500, color: pageIndex == 1 ? null : Colors.white54)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocConsumer<HomeCubit, HomeState>(
              bloc: getIt<HomeCubit>(),
              listener: (context, state) {
                state.maybeWhen(
                  bookmarked: (posts) => setState(() => bookmarkedPosts = posts),
                  orElse: () {},
                );
              },
              builder: (context, state) {
                return PageView(
                  onPageChanged: (value) {
                    setState(() => pageIndex = value);
                    onQuery('');
                  },
                  controller: pageController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: posts.map(
                          (post) {
                            bool isBookmarked = bookmarkedPosts.contains(post);
                            return BlogTile(bookmarkedPosts: bookmarkedPosts, isBookmarked: isBookmarked, post: post);
                          },
                        ).toList(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: bookmarkedPosts.map(
                          (post) {
                            bool isBookmarked = bookmarkedPosts.contains(post);
                            return BlogTile(bookmarkedPosts: bookmarkedPosts, isBookmarked: isBookmarked, post: post);
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                );
              }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class BlogTile extends StatelessWidget {
  const BlogTile({
    super.key,
    required this.bookmarkedPosts,
    required this.isBookmarked,
    required this.post,
  });

  final List<Post> bookmarkedPosts;
  final Post post;
  final bool isBookmarked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: Sizes.baseSingle),
        leading: IconButton(
          onPressed: () => getIt<HomeCubit>().bookmark(bookmarkedPosts, post, isBookmarked),
          icon: isBookmarked ? const Icon(CupertinoIcons.bookmark_fill, color: Colors.white) : const Icon(CupertinoIcons.bookmark),
        ),
        title: Text(post.title, style: context.textStyle.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(post.subTitle, style: context.textStyle.copyWith(fontSize: 14)),
        trailing: const Icon(CupertinoIcons.chevron_forward),
      ),
    );
  }
}
