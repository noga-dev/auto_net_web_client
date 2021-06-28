import 'package:auto_net/components/my_contract.dart';
import 'package:auto_net/components/new_project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/mock.dart';
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
          Text('balance ${useUser.state.walletBalance}'),
          useUser.state.user == null
              ? const Text('No contract')
              : const MyContract(),
          TextButton(
            onPressed: () {
              // useUser.state.web3sign();
              print('use user state in assets ${useUser.state}');
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
                    useUser: useUser.state,
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
