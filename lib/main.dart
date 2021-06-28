import 'package:auto_net/components/main_scaffold.dart';
import 'package:auto_net/screens/assets.dart';
import 'package:auto_net/screens/landing.dart';
import 'package:auto_net/screens/market.dart';
import 'package:auto_net/screens/project_details.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'components/new_project.dart';
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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Autonet',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: useProvider(themeModeProvider).state,
      routeInformationParser: BeamerParser(),
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
      routerDelegate: BeamerDelegate(
        notFoundPage: BeamPage(
          child: MainScaffold(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('404', textScaleFactor: 2),
                  Divider(color: Colors.transparent),
                  Text('Page Not Found'),
                ],
              ),
            ),
          ),
        ),
        locationBuilder: SimpleLocationBuilder(
          routes: {
            '/': (context, state) => const MainScaffold(child: LandingScreen()),
            '/market': (context, state) => const MainScaffold(child: Market()),
            '/projects-view': (context, state) =>
                BeamPage(child: const MainScaffold(child: ProjectView())),
            '/assets': (context, state) =>
                const MainScaffold(child: MyAssets()),
            '/new': (context, state) =>
                MainScaffold(child: EditProject(project: mockProject)),
            '/project-details/:projectAddres': (context, state) => MainScaffold(
                  child: ProjectDetails.fromAddres(
                    projectAddress: state.pathParameters['projectAddres'],
                  ),
                ),
          },
        ),
      ),
    );
  }
}
