import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_blog/routes/router.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  GetIt.I.registerSingleton(BlogRouter());
  await getIt.init();
}
