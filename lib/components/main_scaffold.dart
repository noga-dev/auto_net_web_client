import 'dart:js_util';
import 'dart:math';

import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

const _addressErrorText = 'addrError';
const _assetHeight = 80.0;
const _assetWidth = 140.0;

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: _assetHeight + 40,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              Tooltip(
                message: 'Home',
                child: ElevatedButton(
                  style: ButtonStyle(
                    overlayColor: _getRandomColor(),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0),
                  ),
                  onPressed: () => Beamer.of(context).beamToNamed('/'),
                  child: Transform.scale(
                    scale: 1.6,
                    child: Image.asset(
                      // themeMode.state == ThemeMode.light
                      //     ? 'assets/images/logo-black.png' :
                      'assets/images/logo-white.png',
                      width: _assetWidth,
                      height: _assetHeight,
                    ),
                  ),
                ),
              ),
              MainMenuItem(
                size: size,
                text: 'Market',
                asset: 'shopping-cart',
                callback: () => Beamer.of(context).beamToNamed(
                  '/market',
                ),
              ),
              MainMenuItem(
                size: size,
                text: 'Assets',
                asset: 'property',
                callback: () => Beamer.of(context).beamToNamed('/assets'),
              ),
              MainMenuItem(
                size: size,
                text: 'Node',
                asset: 'nlp',
                callback: () => Beamer.of(context).beamToNamed('/new'),
              ),
            ],
          ),
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
                  : SizedBox(
                      width: size.width * .1,
                      height: _assetHeight - 20,
                      child: Image.network(
                        'assets/assets/images/metamask.png',
                      ),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: RotatedBox(
              quarterTurns: 3,
              child: Transform.scale(
                scale: 1.2,
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
        ],
      ),
      body: child,
    );
  }
}

class MainMenuItem extends HookWidget {
  const MainMenuItem({
    Key? key,
    required this.size,
    required this.text,
    required this.asset,
    required this.callback,
  }) : super(key: key);

  final Size size;
  final String text;
  final String asset;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final isHovering = useState(false);
    return InkWell(
      onTap: () {},
      onHover: (e) => isHovering.value = e,
      child: AnimatedCrossFade(
        crossFadeState: isHovering.value
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 250),
        firstChild: TextButton.icon(
          style: ButtonStyle(
            overlayColor: _getRandomColor(),
            fixedSize: MaterialStateProperty.all(
              const Size(_assetWidth, _assetHeight),
            ),
          ),
          icon: LottieBuilder.asset(
            'assets/anim/$asset.zip',
          ),
          onPressed: callback,
          label: const SizedBox(),
        ),
        secondChild: TextButton(
          style: ButtonStyle(
            overlayColor: _getRandomColor(),
            tapTargetSize: MaterialTapTargetSize.padded,
            fixedSize: MaterialStateProperty.all(
              const Size(_assetWidth, _assetHeight),
            ),
          ),
          onPressed: callback,
          child: Text(text),
        ),
        firstCurve: Curves.easeIn,
        secondCurve: Curves.easeOut,
        layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                key: bottomChildKey,
                child: bottomChild,
              ),
              Positioned(
                key: topChildKey,
                child: topChild,
              ),
            ],
          );
        },
      ),
    );
  }
}

MaterialStateProperty<Color> _getRandomColor() => MaterialStateProperty.all(
      Colors.primaries[Random().nextInt(Colors.primaries.length)]
          .withOpacity(.25),
    );

// class MainAppBar extends StatelessWidget implements PreferredSizeWidget {}
