import 'package:auto_net/models/human.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final StateProvider<ThemeMode> themeModeProvider =
    StateProvider<ThemeMode>((ProviderReference ref) => ThemeMode.dark);

// final StateProvider<Human> us3r =
//     StateProvider<Human>((ProviderReference ref) => Human());