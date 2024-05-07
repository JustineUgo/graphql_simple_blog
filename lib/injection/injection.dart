import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:simple_blog/routes/router.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  GetIt.I.registerSingleton(BlogRouter());
  getIt.init();
}
