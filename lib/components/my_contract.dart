import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyContract extends HookWidget {
  const MyContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(us3r);
    final useAseturi = useState(<Widget>[]);

    print(useUser.state.assets);

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
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('AUTONET USER CONTRACT'),
            const Divider(height: 40),
            Row(
              children: [
                Row(
                  children: [
                    const Text('Available funds: '),
                    Text(
                      useUser.state.userBalance?.getInEther.toString() ??
                          'error ATN',
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                TextButton(
                  onPressed: () {},
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
    );
  }
}
