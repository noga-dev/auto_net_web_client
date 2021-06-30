import 'package:auto_net/components/main_menu.dart';
import 'package:auto_net/components/my_contract.dart';
import 'package:auto_net/screens/assets.dart';
import 'package:auto_net/screens/landing.dart';
import 'package:auto_net/screens/market.dart';
import 'package:auto_net/screens/node.dart';
import 'package:auto_net/utils/common.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';
import 'screens/project_details.dart';
import 'services/providers.dart';

void main() async {
  // uses the command line arguments specified in the gh-actions file (.github/workflows/dart.yml)
  if (const String.fromEnvironment('hostDest') != 'githubPages') {
    setPathUrlStrategy();
  }

  runApp(const ProviderScope(child: MyApp()));
}

const _appBar = MainAppBar();

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);
    MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch as Map<int,Color>);
  }
  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);
    final useChain = useProvider(chainProvider);
    final useIsSignedIn = useProvider(isSignedInProvider);
    final useBeamerDelegate = useState(
      BeamerDelegate(
        transitionDelegate: const NoAnimationTransitionDelegate(),
        notFoundPage: BeamPage(
          child: Scaffold(
            appBar: _appBar,
            body: page404,
          ),
        ),
        locationBuilder: SimpleLocationBuilder(
          routes: {
            '/': (context, state) => BeamPage(
                  key: UniqueKey(),
                  title: 'Autonet Home',
                  child: const Scaffold(
                    appBar: _appBar,
                    body: LandingScreen(),
                  ),
                ),
            '/market': (context, state) => BeamPage(
                  key: UniqueKey(),
                  title: 'Autonet Market',
                  child: const Scaffold(
                    appBar: _appBar,
                    body: Market(),
                  ),
                ),
            '/assets': (context, state) => BeamPage(
                  key: UniqueKey(),
                  title: 'Autonet Assets',
                  child: const Scaffold(
                    appBar: _appBar,
                    body: MyAssets(),
                  ),
                ),
            '/contract': (context, state) => BeamPage(
                  title: 'Autonet New Project',
                  child: const Scaffold(
                    appBar: _appBar,
                    body: MyContract(),
                  ),
                ),
            '/project/:projectAddress': (context, state) => BeamPage(
                  title: 'Autonet Project Details',
                  child: Scaffold(
                    appBar: _appBar,
                    body: ProjectDetailsWrapper(
                      projectAddress: state.pathParameters['projectAddress'] ??
                          '0x27a4c07892df16950a5206de35b40a0358de86c0',
                    ),
                  ),
                ),
            '/node': (context, state) => BeamPage(
                  title: 'Autonet New Project',
                  child: const Scaffold(
                    appBar: _appBar,
                    body: Node(),
                  ),
                ),
          },
        ),
      ),
    );

    if (!useIsSignedIn.state) {
      useUser.state.web3sign().then((value) => useIsSignedIn.state = value);
      useChain.state.retrieveTokenAddress();
    }
      var light = ThemeData(
        brightness: Brightness.light,
        dividerColor: createMaterialColor(Color(0xff4454238)),
        hintColor: Colors.black87,
        primaryColor: createMaterialColor(Color(0xffffffff)),
        primarySwatch: createMaterialColor(Color(0xff4d4d4d)),
        highlightColor: Color(0xff6e6e6e),
        backgroundColor: createMaterialColor(Color(0xeecacaca)),
        accentColor: Color(0xffe0deda),
        canvasColor: Color(0xfff0f0f0));

    var dark = ThemeData(
      buttonColor: createMaterialColor(Color(0xff505663)),
      dividerColor: createMaterialColor(Color(0xffcfc099)),
      brightness: Brightness.dark,
      hintColor: Colors.white70,
      accentColor: createMaterialColor(Color(0xff383736)),
      primaryColor: createMaterialColor(Color(0xff4d4d4d)),
      primarySwatch: createMaterialColor(Color(0xffefefef)),
      highlightColor: Color(0xff6e6e6e),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Autonet',
      theme: light,
      darkTheme: dark,
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
      routerDelegate: useBeamerDelegate.value,
    );
  }
}
