import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:simple_blog/injection/injection.dart';
import 'package:simple_blog/models/post.dart';
import 'package:simple_blog/queries.dart';
import 'package:simple_blog/services/toast_service.dart';
import 'package:simple_blog/theme/theme.dart';

@RoutePage()
class PostScreen extends StatefulWidget {
  const PostScreen({super.key, required this.post});
  final Post? post;
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool isAddPostVisible = true;
  Post? post;

  @override
  void initState() {
    super.initState();
    post = widget.post;

    _titleController.text = post?.title ?? '';
    _subtitleController.text = post?.subTitle ?? '';
    _bodyController.text = post?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    bool isNewPost = widget.post == null;
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.baseDouble),
            child: ListView(
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    const BackButton(),
                    Text("Post Details", style: context.textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 20)),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Title',
                    style: context.textStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      fillColor: Colors.white10,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Subtitle',
                    style: context.textStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _subtitleController,
                    maxLines: 4,
                    minLines: 2,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      fillColor: Colors.white10,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    maxLines: 9,
                    minLines: 6,
                    controller: _bodyController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0)),
                      ),
                      contentPadding: const EdgeInsets.all(8),
                      fillColor: Colors.white10,
                      filled: true,
                      hintText: 'Input body of the post',
                      hintStyle: context.textStyle.copyWith(fontSize: 14, color: Colors.white.withOpacity(.5)),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                if (isNewPost)
                  Visibility(
                    visible: isAddPostVisible,
                    child: Mutation(
                      options: MutationOptions(
                        document: gql(newBlog),
                        onCompleted: (dynamic resultData) {
                          Map<String, dynamic> data = resultData['createBlog'];
                          Map<String, dynamic> postData = data['blogPost'];
                          Post newPost = Post.fromJson(postData);
                          setState(() => post = newPost);
                          setState(() => isAddPostVisible = false);

                          getIt<Toast>()
                              .showMessage(context: context, title: "Success!", message: "Post created! Go back to see all posts", type: ToastType.success);
                        },
                        onError: (OperationException? error) {
                          error;
                          getIt<Toast>().showMessage(
                              context: context, title: "Error!", message: "Unable to create post. Check internet and try again!", type: ToastType.error);
                        },
                      ),
                      builder: (runMutation, result) {
                        return result?.isLoading ?? false
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                                ),
                                onPressed: () => runMutation({
                                  "title": _titleController.text,
                                  "subTitle": _subtitleController.text,
                                  "body": _bodyController.text,
                                }),
                                child: Text('Add Post', style: context.textStyle),
                              );
                      },
                    ),
                  ),
                const SizedBox(height: 10),
                if (!isNewPost)
                  Mutation(
                    options: MutationOptions(
                      document: gql(updateBlog),
                      onCompleted: (dynamic resultData) {
                        Map<String, dynamic> data = resultData['updateBlog'];
                        Map<String, dynamic> postData = data['blogPost'];
                        Post newPost = Post.fromJson(postData);
                        setState(() => post = newPost);

                        getIt<Toast>()
                            .showMessage(context: context, title: "Success!", message: "Post updated! Go back to see all posts", type: ToastType.success);
                      },
                      onError: (OperationException? error) {
                        error;
                        getIt<Toast>().showMessage(
                            context: context, title: "Error!", message: "Unable to update post. Check internet and try again!", type: ToastType.error);
                      },
                    ),
                    builder: (runMutation, result) {
                      return result?.isLoading ?? false
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                                backgroundColor: MaterialStateProperty.all(Colors.purple),
                              ),
                              onPressed: () => runMutation({
                                "blogId": widget.post!.id,
                                "title": _titleController.text,
                                "subTitle": _subtitleController.text,
                                "body": _bodyController.text,
                              }),
                              child: Text('Edit Post', style: context.textStyle),
                            );
                    },
                  ),
                const SizedBox(height: 10),
                if (widget.post != null)
                  Mutation(
                    options: MutationOptions(
                      document: gql(deleteBlog),
                      onCompleted: (dynamic resultData) {
                        context.router.maybePopTop('delete');
                      },
                      onError: (OperationException? error) {
                        error;
                        getIt<Toast>().showMessage(
                            context: context, title: "Error!", message: "Unable to delete post. Check internet and try again!", type: ToastType.error);
                      },
                    ),
                    builder: (runMutation, result) {
                      return result?.isLoading ?? false
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(const Color(0xff21242C)),
                                minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                              ),
                              onPressed: () => runMutation({
                                "blogId": widget.post!.id,
                              }),
                              child: Text('Delete Post', style: context.textStyle.copyWith(color: Colors.red)),
                            );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//TODO: verify all form fields