import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingScreen extends HookWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvider(themeModeProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [0.0, 1.0],
          colors: themeMode.state == ThemeMode.dark
              ? [
                  const Color(0xff4c4c4c),
                  const Color(0xff424242),
                ]
              : [
                  const Color(0xffc3c3c3),
                  const Color(0xffefefef),
                ],
        ),
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          fit: BoxFit.fitWidth,
          image: AssetImage(
            themeMode.state == ThemeMode.dark
                ? 'assets/images/bg-dark.jpg'
                : 'assets/images/bg-light.jpg',
          ),
        ),
      ),
      child: Card(
        color: Theme.of(context).cardColor.withOpacity(.5),
        child: const MaterialBanner(
          backgroundColor: Colors.transparent,
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
    );
  }
}
