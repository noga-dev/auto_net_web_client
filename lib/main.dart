// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:auto_net/components/routes.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'services/providers.dart';

void main() async {
  // uses the command line arguments specified in the gh-actions file (.github/workflows/dart.yml)
  if (const String.fromEnvironment('hostDest') != 'githubPages') {
    setPathUrlStrategy();
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);
    final useChain = useProvider(chainProvider);
    final useIsSignedIn = useProvider(isSignedInProvider);

    if (!useIsSignedIn.state) {
      useUser.state.web3sign().then((value) => useIsSignedIn.state = value);
      useChain.state.retrieveTokenAddress();
    }

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Autonet',
      theme: mainLightThemeData,
      darkTheme: mainDarkThemeData,
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
      routerDelegate: beamerDelegate,
    );
  }
}
