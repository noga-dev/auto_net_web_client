import 'package:auto_net/components/my_contract.dart';
import 'package:auto_net/components/new_project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:web3dart/web3dart.dart';

const _divider = Divider(
  color: Colors.transparent,
  height: 20,
);

class MyAssets extends HookWidget {
  const MyAssets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final userAddress = useState(ethereum?.selectedAddress ?? _addrError);
    final useUser = useProvider(userProvider);

    if (!useProvider(isSignedInProvider).state && kReleaseMode) {
      return page403;
    }

    // useUser.state.web3sign();
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 200.0,
              child: Card(
                child: ListTile(
                  title: const Text('Balance'),
                  trailing: Text(
                    // ignore: prefer_interpolation_to_compose_strings
                    (useUser.state.walletBalance
                                ?.getValueInUnit(EtherUnit.ether)
                                .toStringAsPrecision(4) ??
                            'N/A') +
                        'Ξ',
                  ),
                ),
              ),
            ),
            _divider,
            TextButton(
              style: buttonStyle,
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: EditProject(
                    project: mockProject
                      ..shareholders = {}
                      ..investors = {}
                      ..team = {}
                      ..split = 5.0,
                    useUser: useUser.state,
                  ),
                ),
              ),
              child: const Text('Create a new project'),
            ),
            _divider,
            useUser.state.user == null
                ? const Text('No contracts found')
                : const MyContract(),
          ],
        ),
      ),
    );
  }
}
