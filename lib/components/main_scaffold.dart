import 'dart:js_util';
import 'dart:math';

import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

const _addressErrorText = 'addrError';

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
            TextButton.icon(
              style: ButtonStyle(
                overlayColor: _getRandomColor(),
              ),
              onPressed: () {},
              icon: LottieBuilder.asset(
                'assets/anim/shopping-cart.zip',
                height: 80,
              ),
              label: const Text('Market'),
            ),
            TextButton.icon(
              style: ButtonStyle(
                overlayColor: _getRandomColor(),
              ),
              onPressed: () {},
              icon: LottieBuilder.asset(
                'assets/anim/property.zip',
                height: 80,
              ),
              label: const Text('Assets'),
            ),
            TextButton.icon(
              style: ButtonStyle(
                overlayColor: _getRandomColor(),
              ),
              onPressed: () {},
              icon: LottieBuilder.asset(
                'assets/anim/nlp.zip',
                height: 80,
              ),
              label: const Text('Node'),
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
                overlayColor: _getRandomColor(),
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
                      style: TextStyle(
                        color: themeMode.state == ThemeMode.dark
                            ? Colors.white
                            : Colors.black,
                      ),
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
                  overlayColor: _getRandomColor(),
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

MaterialStateProperty<Color> _getRandomColor() => MaterialStateProperty.all(
      Colors.primaries[Random().nextInt(Colors.primaries.length)]
          .withOpacity(.25),
    );
