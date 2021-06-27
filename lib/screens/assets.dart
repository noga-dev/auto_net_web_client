import 'package:auto_net/components/main_scaffold.dart';
import 'package:auto_net/components/my_contract.dart';
import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyAssets extends HookWidget {
  const MyAssets({Key? key}) : super(key: key);
  // var number;
  @override
  Widget build(BuildContext context) {
    final userAddress = useState(ethereum?.selectedAddress);
    final useUser = useProvider(us3r);
    useUser.state.web3sign();
    return MainScaffold(
      child: Center(
        child: Column(
          children: [
            Text(
              userAddress.value == 'addrError'
                  ? 'not logged in'
                  : userAddress.value ?? 'err',
            ),
            const SizedBox(height: 100),
            Text('balance ${useUser.state.balance}'),
            useUser.state.user == null
                ? const Text('No contract')
                : MyContract(),
            TextButton(
              onPressed: () {
                useUser.state.web3sign();
                print('use user state in assets ${useUser.state}');
              },
              child: const Text('get the details'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateContractButton extends StatelessWidget {
  const CreateContractButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(us3r);

    return SizedBox(
      child: Center(
        child: Text(
          useUser.state.user == null ? 'No contract' : 'Contract is here',
        ),
      ),
    );
  }
}
