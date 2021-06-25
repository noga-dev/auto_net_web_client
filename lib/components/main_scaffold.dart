import 'dart:js_util';

import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _addressErrorText = 'addrError';
const _overlayColor = Color(0x90e57373);

class MainScaffold extends HookWidget {
  const MainScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvider(themeModeProvider);
    final selectedAddress =
        useState(ethereum?.selectedAddress ?? _addressErrorText);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        title: ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text('Market'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Assets'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Node'),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0),
                overlayColor: MaterialStateProperty.all(_overlayColor),
              ),
              onPressed: () async {
                if (ethereum == null ||
                    selectedAddress.value != _addressErrorText) {
                  return;
                }
                await promiseToFuture(
                  ethereum!
                      .request(RequestParams(method: 'eth_requestAccounts')),
                );
                selectedAddress.value =
                    ethereum?.selectedAddress ?? _addressErrorText;
              },
              child: selectedAddress.value != _addressErrorText
                  ? Text(
                      getShortAddress(selectedAddress.value),
                      textScaleFactor: 1.2,
                    )
                  : Transform.scale(
                      scale: .8,
                      child: Image.network(
                        'assets/images/metamask.png',
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: RotatedBox(
              quarterTurns: 3,
              child: Transform.scale(
                scale: 1.6,
                child: Switch(
                  overlayColor:
                      MaterialStateColor.resolveWith((states) => _overlayColor),
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
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 30)),
        ],
      ),
      body: child,
    );
  }
}
