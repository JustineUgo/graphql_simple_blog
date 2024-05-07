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
