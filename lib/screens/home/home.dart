import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_blog/screens/home/widgets/search_widget.dart';
import 'package:simple_blog/theme/theme.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.baseDouble),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  color: const Color(0xff21242C),
                  child: Column(
                    children: [
                      Text("Simple Blog", style: context.textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 20)),
                      const SizedBox(height: 20),
                      Search(onQuery: (query) {}),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                          children: [
                            Text("All", style: context.textStyle.copyWith(fontWeight: FontWeight.w500)),
                            const SizedBox(width: 30),
                            Text("Bookmarked", style: context.textStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white54)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            30,
                            (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text("Title", style: context.textStyle.copyWith(fontWeight: FontWeight.w600)),
                                subtitle: Text("Subtitle", style: context.textStyle.copyWith(fontSize: 14)),
                                trailing: const Icon(CupertinoIcons.chevron_forward),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
