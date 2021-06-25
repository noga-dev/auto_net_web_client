import 'package:auto_net/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'components/main_scaffold.dart';
import 'services/providers.dart';

void main() async {
  setPathUrlStrategy();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Autonet',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: useProvider(themeModeProvider).state,
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.4),
          child: child!,
        ),
        home: const MainScreen(),
      );
}

class MainScreen extends HookWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Center(
        child: ListView(
          children: [
            const Card(
              child: MaterialBanner(
                padding: EdgeInsets.all(20),
                content: Text(
                  'just a material banner test.',
                ),
                leading: Icon(
                  Icons.credit_card,
                ),
                actions: [
                  BackButton(),
                  CloseButton(),
                ],
              ),
            ),
            Wrap(
              children: List.generate(
                10,
                (index) => Card(
                  child: Row(
                    children: List.generate(
                      20,
                      (index) => const Card(
                        child: Placeholder(
                          fallbackHeight: 50,
                          fallbackWidth: 50,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
