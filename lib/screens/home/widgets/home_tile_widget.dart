import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_blog/injection/injection.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/routes/router.gr.dart';
import 'package:simple_blog/screens/home/cubit/home_cubit.dart';
import 'package:simple_blog/services/toast_service.dart';
import 'package:simple_blog/theme/theme.dart';

class BlogTile extends StatelessWidget {
  const BlogTile({
    super.key,
    required this.bookmarkedPosts,
    required this.isBookmarked,
    required this.post,
    required this.onReload,
  });

  final List<Post> bookmarkedPosts;
  final Post post;
  final bool isBookmarked;
  final VoidCallback? onReload;

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
        onTap: () async {
          var result = await context.router.push(PostRoute(post: post));

          if (onReload != null) onReload!();
          if (result == 'delete') getIt<Toast>().showMessage(context: context, title: "Success!", message: "Post deleted!", type: ToastType.success);
        },
      ),
    );
  }
}
