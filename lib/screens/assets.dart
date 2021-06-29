import 'package:auto_net/components/my_contract.dart';
import 'package:auto_net/components/new_project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyAssets extends HookWidget {
  const MyAssets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userAddress = useState(ethereum?.selectedAddress);
    final useUser = useProvider(userProvider);

    if (!useProvider(isSignedInProvider).state) {
      return page403;
    }

    // useUser.state.web3sign();
    return Center(
      child: Column(
        children: [
          Text(
            userAddress.value == 'addrError'
                ? 'not logged in'
                : userAddress.value ?? 'err',
          ),
          const SizedBox(height: 100),
          Text('balance ${useUser.walletBalance}'),
          useUser.user == null ? const Text('No contract') : const MyContract(),
          TextButton(
            onPressed: () {
              // useUser.state.web3sign();
              print('use user state in assets $useUser');
            },
            child: const Text('get the details'),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: EditProject(
                    project: mockProject
                      ..shareholders = {}
                      ..investors = {}
                      ..team = {}
                      ..split = 5.0,
                    useUser: useUser,
                  ),
                ),
              );
            },
            child: const Text('new project'),
          ),
        ],
      ),
    );
  }
}

class CreateContractButton extends StatelessWidget {
  const CreateContractButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);

    return SizedBox(
      child: Center(
        child: Text(
          useUser.user == null ? 'No contract' : 'Contract is here',
        ),
      ),
    );
  }
}
