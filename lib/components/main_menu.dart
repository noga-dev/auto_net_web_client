import 'dart:js_util';
import 'dart:ui';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

const _addressErrorText = 'addrError';
const _assetHeight = 60.0;
const _assetWidth = 140.0;

class MainAppBar extends HookWidget with PreferredSizeWidget {
  const MainAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvider(themeModeProvider);
    final selectedAddress =
        useState(ethereum?.selectedAddress ?? _addressErrorText);
    final size = MediaQuery.of(context).size;
    final useUser = useProvider(userProvider);
    final useIsSignedInProvider = useProvider(isSignedInProvider);

    return AppBar(
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
                  overlayColor: getRandomMaterialStateColor(),
                  backgroundColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                  elevation: MaterialStateProperty.all(0),
                ),
                onPressed: () => Beamer.of(context).beamToNamed('/'),
                child: Transform.scale(
                  scale: 2,
                  child: Image.asset(
                    themeMode.state == ThemeMode.light
                        ? 'assets/images/logo-black.png'
                        : 'assets/images/logo-white.png',
                    width: _assetWidth,
                    height: _assetHeight,
                  ),
                ),
              ),
            ),
            _MainMenuItem(
              size: size,
              text: 'Market',
              asset: 'shopping-cart',
              callback: () => Beamer.of(context).beamToNamed(
                '/market',
              ),
            ),
            _MainMenuItem(
              size: size,
              text: 'Assets',
              asset: 'property',
              callback: () => Beamer.of(context).beamToNamed('/assets'),
              enabled: selectedAddress.value != _addressErrorText,
            ),
            _MainMenuItem(
              size: size,
              text: 'Node',
              asset: 'nlp',
              callback: () => Beamer.of(context).beamToNamed('/node'),
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
                  borderRadius: BorderRadius.circular(
                    60,
                  ),
                ),
              ),
              backgroundColor: getRandomMaterialStateColor(),
              elevation: MaterialStateProperty.all(.7),
              overlayColor: getRandomMaterialStateColor(),
            ),
            onPressed: () async {
              if (ethereum == null ||
                  selectedAddress.value != _addressErrorText) {
                return;
              }
              await promiseToFuture(
                ethereum!.request(
                  RequestParams(method: 'eth_requestAccounts'),
                ),
              );
              selectedAddress.value =
                  ethereum?.selectedAddress ?? _addressErrorText;

              unawaited(useUser.state
                  .web3sign()
                  .then((value) => useIsSignedInProvider.state = value));
            },
            child: selectedAddress.value != _addressErrorText
                ? Builder(
                    builder: (context) {
                      return FocusTraversalGroup(
                        descendantsAreFocusable: false,
                        child: TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  60,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {},
                          child: Center(
                            child: Text(
                              getShortAddress(selectedAddress.value),
                              style: TextStyle(
                                color: themeMode.state == ThemeMode.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    width: _assetHeight,
                    height: _assetHeight,
                    child: Image.network(
                      'assets/assets/images/metamask.png',
                    ),
                  ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 7.0, left: 16.0),
          child: RotationTransition(
            turns: const AlwaysStoppedAnimation(-45 / 360),
            child: Switch(
              overlayColor: getRandomMaterialStateColor(),
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_assetHeight + 20.0);
}

class _MainMenuItem extends HookWidget {
  const _MainMenuItem({
    Key? key,
    required this.size,
    required this.text,
    required this.asset,
    required this.callback,
    this.enabled = true,
  }) : super(key: key);

  final bool enabled;
  final Size size;
  final String text;
  final String asset;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final isHovering = useState(false);
    return Tooltip(
      message: enabled ? text : 'Log in to view your assets',
      child: InkWell(
        onTap: enabled ? callback : null,
        focusColor: getRandomMaterialColor(),
        onHover: (e) => isHovering.value = e,
        child: AnimatedCrossFade(
          crossFadeState: isHovering.value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
          secondChild: TextButton.icon(
            style: ButtonStyle(
              overlayColor: getRandomMaterialStateColor(),
              fixedSize: MaterialStateProperty.all(
                const Size(_assetWidth, _assetHeight),
              ),
            ),
            icon: LottieBuilder.asset(
              'assets/anim/$asset.zip',
            ),
            onPressed: enabled ? callback : null,
            label: const SizedBox(),
          ),
          firstChild: TextButton(
            style: ButtonStyle(
              overlayColor: getRandomMaterialStateColor(),
              tapTargetSize: MaterialTapTargetSize.padded,
              fixedSize: MaterialStateProperty.all(
                const Size(_assetWidth, _assetHeight),
              ),
            ),
            onPressed: enabled ? callback : null,
            child: Text(text),
          ),
          firstCurve: Curves.easeIn,
          secondCurve: Curves.easeOut,
          layoutBuilder: (firstChild, firstKey, secondChild, secondKey) {
            return FocusTraversalGroup(
              descendantsAreFocusable: false,
              child: Stack(
                children: [
                  Positioned(
                    key: secondKey,
                    child: secondChild,
                  ),
                  Positioned(
                    top: 0,
                    key: firstKey,
                    child: firstChild,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
