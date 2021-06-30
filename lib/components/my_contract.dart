import 'package:auto_net/components/new_project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyContract extends HookWidget {
  const MyContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);
    final useAseturi = useState(<Widget>[]);
    final useErc20 =
        useFuture(useUser.state.getErc20()); // TODO(Agon): continue from here

    useEffect(() {}, []);

    if (!useProvider(isSignedInProvider).state) {
      return page403;
    }

    useUser.state.assets.forEach((key, value) {
      useAseturi.value.add(
        Row(
          children: [
            Text(key.toString()),
            const VerticalDivider(
              indent: 4,
            ),
            Text(value.toString()),
            const VerticalDivider(width: 4),
            TextButton(
              onPressed: () {},
              child: const Text('SELL'),
            )
          ],
        ),
      );
      print('hopa');
    });

    return SizedBox(
      width: 700,
      child: Card(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Autonet user contract'.toUpperCase(),
                ),
                const Divider(height: 40),
                Row(
                  children: [
                    Row(
                      children: [
                        const Text('Available funds: '),
                        Text(useErc20.data.toString()
                            // ignore: lines_longer_than_80_chars
                            // useUser.state.walletBalance?.getInEther.toString() ?? 'error ATN',
                            ),
                      ],
                    ),
                    const SizedBox(width: 40),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (
                              context,
                            ) {
                              return EditProject(
                                project: mockProject,
                                useUser: useUser.state,
                              );
                            });
                      },
                      child: const Text('WIDTHDRAW'),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: useAseturi.value,
                ),
                const Divider(height: 70),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Developing in TensorFlow? Add your project here.',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
