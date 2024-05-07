import 'package:auto_route/auto_route.dart';
import 'package:simple_blog/routes/router.gr.dart';

@AutoRouterConfig()
class BlogRouter extends $BlogRouter{

@override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: '/'),
    AutoRoute(page: PostRoute.page, path: '/post'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}