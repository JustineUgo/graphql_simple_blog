import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_blog/injection/injection.dart';
import 'package:simple_blog/routes/router.dart';

void main() async {
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

  await configureDependencies();
  runApp(const SimpleBlog());
}

class SimpleBlog extends StatelessWidget {
  const SimpleBlog({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
