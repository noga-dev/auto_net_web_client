import 'dart:js_util';

import 'package:auto_net/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/chain.dart';
import 'services/providers.dart';

// final _chain = Chain();
late Web3Provider _web3;

void main() async {
  setPathUrlStrategy();

  if (ethereum == null) {
    return;
  } else {
    _web3 = Web3Provider(ethereum!);
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Autonet',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: useProvider(themeModeProvider).state,
        home: const MainScreen(),
      );
}

class MainScreen extends HookWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const addressError = 'addrError';

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvider(themeModeProvider);
    final selectedAddress = useState(ethereum?.selectedAddress ?? addressError);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight * 1.2,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60))),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0),
            ),
            onPressed: () async {
              if (ethereum == null || selectedAddress.value != addressError) {
                return;
              }
              await promiseToFuture(ethereum!
                  .request(RequestParams(method: 'eth_requestAccounts')));
              selectedAddress.value = ethereum?.selectedAddress ?? addressError;
            },
            child: selectedAddress.value != addressError
                ? Text(
                    getShortAddress(selectedAddress.value),
                    textScaleFactor: 1.2,
                  )
                : Image.network(
                    'assets/images/metamask.png',
                    height: Theme.of(context).buttonTheme.height,
                  ),
          ),
          const SizedBox(width: 5),
          RotatedBox(
            quarterTurns: 3,
            child: Switch(
              activeThumbImage: const AssetImage('assets/images/sun.png'),
              inactiveThumbImage:
                  const AssetImage('assets/images/new_moon.png'),
              inactiveThumbColor: Colors.white,
              activeColor: Colors.amber,
              value: themeMode.state == ThemeMode.light,
              onChanged: (val) => themeMode.state == ThemeMode.light
                  ? themeMode.state = ThemeMode.dark
                  : themeMode.state = ThemeMode.light,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Placeholder(),
      ),
    );
  }
}
