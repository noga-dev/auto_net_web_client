import 'package:auto_net/screens/assets/atn_contract.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyAssets extends HookWidget {
  const MyAssets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chainProvider);
    if (!useProvider(isSignedInProvider).state && kReleaseMode) {
      return page403;
    }

    if (!useChain.isPopulated) {
      useChain.populate();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: useProvider(chainProvider).isPopulated
            ? MyContractView()
            : const CircularProgressIndicator(),
      ),
    );
  }
}
