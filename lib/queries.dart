String get allBlogs => """
query fetchAllBlogs {
  allBlogPosts {
    id
    title
    subTitle
    body
    dateCreated
  }
}
""";

String get newBlog => r"""
mutation createBlogPost($title: String!, $subTitle: String!, $body: String!) {
  createBlog(title: $title, subTitle: $subTitle, body: $body) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
    }
  }
}
""";

String get updateBlog => r"""
mutation updateBlogPost($blogId: String!, $title: String!, $subTitle: String!, $body: String!) {
  updateBlog(blogId: $blogId, title: $title, subTitle: $subTitle, body: $body) {
    success
    blogPost {
      id
      title
      subTitle
      body
      dateCreated
    }
  }
}
""";

String get deleteBlog => r"""
mutation deleteBlogPost($blogId: String!) {
  deleteBlog(blogId: $blogId) {
    success
  }
}
""";
