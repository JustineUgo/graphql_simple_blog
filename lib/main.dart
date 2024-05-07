import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:simple_blog/injection/injection.dart';
import 'package:simple_blog/routes/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //color status bar
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xff21242C),
    ),
  );

  //prevent rotation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);


  await initHiveForFlutter();

  configureDependencies();
  runApp(const SimpleBlog());
}

class SimpleBlog extends StatelessWidget {
  const SimpleBlog({super.key});
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: getIt<ValueNotifier<GraphQLClient>>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: getIt<BlogRouter>().config(),
        theme: ThemeData(
          listTileTheme: const ListTileThemeData(tileColor: Color(0xff31363F)),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff31363F)))),
          cardTheme: const CardTheme(color: Color(0xff31363F)),
          scaffoldBackgroundColor: const Color(0xff21242C),
          useMaterial3: true,
        ),
      ),
    );
  }
}
