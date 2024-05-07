import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class BlogGraphqlClient {
  void mutation({required String document, required Map<String, dynamic> variable});
  QueryResult query({required String document, required Map<String, dynamic> variable});
}

@Singleton(as: BlogGraphqlClient)
class BlogGraphqlClientImpl implements BlogGraphqlClient {
  @override
  void mutation({required String document, required Map<String, dynamic> variable}) {
    
  }

  @override
  QueryResult query({required String document, required Map<String, dynamic> variable}) {
    QueryHookResult value = useQuery(
      QueryOptions(
        document: gql("""query fetchAllBlogs {
  allBlogPosts {
    id
    title
    subTitle
    body
    dateCreated
  }
}"""), // this is the query string you just created
        // variables: variable,
        // onComplete: (data) {
        //   data;
        // },
        // onError: (error) {
        //   if (error is OperationException) {
        //     // OperationException occurs when there's an error in the GraphQL operation
        //     print('GraphQL operation error: ${error.graphqlErrors}');
        //   } else if (error is CacheMissException) {
        //     // CacheMissException occurs when the requested data is not found in the cache
        //     print('Cache miss error: ${error?.message}');
        //   } else if (error is NetworkException) {
        //     // NetworkException occurs when there's a network-related error
        //     print('Network error: ${error?.message}');
        //   } else {
        //     // Handle other types of errors
        //     print('Unexpected error: $error');
        //   }
        // },
      ),
    );
    value;
    return value.result;
  }
}
