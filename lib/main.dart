import 'package:auto_net/components/main_scaffold.dart';
import 'package:auto_net/screens/assets.dart';
import 'package:auto_net/screens/landing.dart';
import 'package:auto_net/screens/market.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'components/new_project.dart';
import 'models/project.dart';
import 'screens/projects.dart';
import 'services/providers.dart';

void main() async {
  setPathUrlStrategy();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chain);
    useChain.state.populate();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Autonet',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: useProvider(themeModeProvider).state,
      builder: (context, child) {
        if (MediaQuery.of(context).size.aspectRatio < 0.8) {
          return const Center(
            child: Text('Mobile is not supported'),
          );
        }
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.2),
          child: child!,
        );
      },
      routes: {
        '/market': (context) => const MainScaffold(child: Market()),
        '/': (context) => const MainScaffold(child: LandingScreen()),
        '/assets': (context) => const MainScaffold(child: MyAssets()),
        '/project': (context) => const MainScaffold(child: ProjectView()),
        '/new': (cntext) => MainScaffold(
              child: EditProject(
                project: Project(
                  name: null,
                  address: null,
                  category: null,
                  description: null,
                  imgUrl: null,
                  mature: true,
                  github: 'https://github.com/openai/gpt-3',
                ),
              ),
            ),
      },
      initialRoute: '/market',
    );
  }
}
