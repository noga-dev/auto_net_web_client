import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

class MyContract extends HookWidget {
  // const MyContract({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(us3r);
    List<Widget> aseturi = [];
    print(useUser.state.assets);

    useUser.state.assets.forEach((key, value) {
      aseturi.add(
        Row(
          children: [
            Text(key.toString()),
          
            const VerticalDivider(indent: 4,),
            Text(value.toString()),
            const VerticalDivider(width: 4),
            TextButton(child:Text("SELL"),
              onPressed:(){},
            )
          ],
        ),
      );
      print("hopa");
    });

    return SizedBox(
      width: 700,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("AUTONET USER CONTRACT"),
            const Divider(height: 40),
            Row(
              children: [
                Row(
                  children: [
                    Text("Available funds: "),
                    Text(useUser.state.userBalance?.getInEther.toString() ?? 'error' + " ATN"),
                  ],
                ),
                SizedBox(width: 40),
                TextButton(
                  child: Text("WIDTHDRAW"),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
                children: aseturi
            )
          ],
        ),
      ),
    );
  }
}
