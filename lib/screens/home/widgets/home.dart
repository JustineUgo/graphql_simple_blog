import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_blog/injection/injection.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/routes/router.gr.dart';
import 'package:simple_blog/screens/home/cubit/home_cubit.dart';
import 'package:simple_blog/screens/home/cubit/home_state.dart';
import 'package:simple_blog/screens/home/widgets/home_tile_widget.dart';
import 'package:simple_blog/screens/home/widgets/search_widget.dart';
import 'package:simple_blog/theme/theme.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.posts, this.refetchCallback});
  final List<Post> posts;
  final VoidCallback? refetchCallback;
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
                    const Spacer(),
                    TextButton(
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple)),
                        onPressed: () async {
                          await context.router.push(PostRoute(post: null));
                          if (widget.refetchCallback != null) widget.refetchCallback!();
                        },
                        child: Text("Add Post", style: context.textStyle)),
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
                            return BlogTile(bookmarkedPosts: bookmarkedPosts, isBookmarked: isBookmarked, post: post, onReload: widget.refetchCallback);
                          },
                        ).toList(),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: bookmarkedPosts.map(
                          (post) {
                            bool isBookmarked = bookmarkedPosts.contains(post);
                            return BlogTile(bookmarkedPosts: bookmarkedPosts, isBookmarked: isBookmarked, post: post, onReload: widget.refetchCallback);
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
