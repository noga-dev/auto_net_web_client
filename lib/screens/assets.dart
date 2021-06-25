import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
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
    // final useUser = useProvider(us3r);

    return Column(
      children: [
        Text(
          userAddress.value == 'addrError'
              ? 'not logged in'
              : userAddress.value ?? 'err',
        ),
        const SizedBox(height: 100),
        Text('balance ${useUser.state.balance}'),
        Text(useUser.state.user == null ? 'No contract' : 'Contract is here'),
        TextButton(
          onPressed: () {
            useUser.state.web3sign();
          },
          child: const Text('get the details'),
        ),
      ],
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
