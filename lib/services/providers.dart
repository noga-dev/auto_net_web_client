import 'package:auto_net/models/human.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((ProviderReference ref) => ThemeMode.dark);

final StateProvider<Human> us3r =
    StateProvider<Human>((ProviderReference ref) => Human());

Human us33r=Human();

class UserExt extends HookWidget{
 final useUser = useProvider(us3r);
  @override
  Widget build(BuildContext context) {
    useUser.state=us33r;
        throw UnimplementedError();
    }
}