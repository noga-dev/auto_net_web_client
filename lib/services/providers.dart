import 'package:auto_net/models/human.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/chain.dart';
import 'node.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

final us3r = StateProvider<Human>((ref) => Human());

final chain = StateProvider<Chain>((ref) => Chain());

final nodeProvider = ChangeNotifierProvider((ref) => NodeChangeNotifier());
