// ignore_for_file: lines_longer_than_80_chars
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingScreen extends HookWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvider(themeModeProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [0.0, 1.0],
          colors: themeMode.state == ThemeMode.dark
              ? [
                  const Color(0xff4c4c4c),
                  const Color(0xff424242),
                ]
              : [
                  const Color(0xffc3c3c3),
                  const Color(0xffefefef),
                ],
        ),
        image: DecorationImage(
          alignment: Alignment.center,
          fit: BoxFit.fitHeight,
          image: AssetImage(
            themeMode.state == ThemeMode.dark
                ? 'assets/images/bg-dark.jpg'
                : 'assets/images/bg-light.jpg',
          ),
        ),
      ),
      child: const Center(
        child: SizedBox(
          width: 600,
          height: 540,
          child: Card(
            child: BuyToken(),
          ),
        ),
      ),
    );
  }
}

class BuyToken extends HookWidget {
  const BuyToken({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chainProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          padding: const EdgeInsets.symmetric(vertical: 4),
          width: 400,
          color: Theme.of(context).cardColor,
          child: const Center(
            child: Text('INITIAL TOKEN SALE'),
          ),
        ),
        const SizedBox(height: 20),
        DefaultTextStyle(
          style: TextStyle(
            fontFamily: 'Roboto Mono',
            color: Theme.of(context).textTheme.bodyText1?.color ?? Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SizedBox(height: 4),
                  Text('Token address: '),
                  SizedBox(height: 5),
                  Text('Total supply: '),
                  Text('Current price: '),
                  Text('Tokens sold: '),
                  Text('Accounts: '),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: useChain.state.tokenAddress,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1600),
                          content: SizedBox(
                            height: 70,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Token address was copied to cliboard.',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.copy, size: 15),
                        Text(' Copy to clipboard')
                      ],
                    ),
                  ),
                  const Text('10000000000'),
                  const Text('1 Finney (.001 ETH)'),
                  const Text('742381'),
                  const Text('3324'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Container(
          width: 420,
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 9),
              Text(
                'Automated price increase:',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                '* The first 5M tokens are sold at the price of .001 ETH,',
              ),
              Text(
                '* Each of the following 2.5M tokens told trigger a 0.00025 ETH increase in price.',
              ),
              SizedBox(height: 9)
            ],
          ),
        ),
        const SizedBox(height: 39),
        useProvider(isSignedInProvider).state
            ? TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).buttonColor,
                  elevation: 1,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                      content: SizedBox(
                        height: 500,
                        width: 500,
                        child: BuyTokenDialog(),
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 170,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://i.ibb.co/kXVw8Z2/logo64x64.png',
                          height: 30,
                        ),
                        const SizedBox(width: 7),
                        const Text('Buy ATN'),
                      ],
                    ),
                  ),
                ),
              )
            : TextButton.icon(
                onPressed: null,
                style: getButtonStyle(context),
                label: const Text(
                    'Log in with Matemask to interact with contract'),
                icon: const Icon(Icons.info),
              ),
        const SizedBox(height: 30)
      ],
    );
  }
}

class BuyTokenDialog extends HookWidget {
  const BuyTokenDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chainProvider);
    final useUser = useProvider(userProvider);
    final useError = useState('');
    final useDiff = useState(.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Funds in your wallet: ${useUser.state.walletBalance?.getValueInUnit(EtherUnit.ether)} ETH',
        ),
        Text(
          (useUser.state.walletBalance?.getValueInUnit(EtherUnit.finney) ??
                      0) >=
                  2500
              ? 'Maximum amount you can buy: ${2500} ATN'
              : 'Maximum amount you can buy: ${useUser.state.walletBalance?.getValueInUnit(EtherUnit.finney)} ATN',
          style: const TextStyle(fontSize: 19),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Amount to buy: ',
            style: TextStyle(fontSize: 19),
          ),
          SizedBox(
              width: 100,
              child: TextField(
                style: const TextStyle(
                  fontSize: 19,
                ),
                onChanged: (value) {
                  double.tryParse(value) != null
                      // ignore: unnecessary_statements
                      ? {
                          useDiff.value = double.parse(value),
                          if (useDiff.value > 2500) {useDiff.value = 2500}
                        }
                      : useDiff.value = 0;
                },
                maxLines: 1,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontSize: 15),
                  labelText: 'Enter',
                  alignLabelWithHint: true,
                ),
              )),
          const Text(
            'ATN',
            style: TextStyle(fontSize: 19),
          ),
        ]),
        Text(
          useError.value,
          style: const TextStyle(color: Colors.red),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 100,
          height: 50,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
            ),
            onPressed: () async {
              if (useDiff.value == 0) {
                useError.value = 'INVALID AMOUNT';
              } else {
                Navigator.of(context).pop();
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: SizedBox(
                      width: 500,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: FutureBuilder(
                        future: useUser.state.buyATN(
                          EtherAmount.fromUnitAndValue(
                            EtherUnit.finney,
                            useDiff.value,
                          ),
                        ),
                        builder: (context, snapshot) {
                          if (useUser.state.creatingContract) {
                            return const Center(
                              child: SizedBox(
                                height: 140,
                                width: 140,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text('Transaction complete!'),
                                const SizedBox(height: 10),
                                const SizedBox(height: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 85,
                                  ),
                                  child: const Text(
                                    "If you don't already have ATN in your wallet, add a custom token with the following address:",
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () => Clipboard.setData(
                                        ClipboardData(
                                          text: useChain.state.tokenAddress,
                                        ),
                                      ),
                                      label: Text(useChain.state.tokenAddress),
                                      icon: const Icon(
                                        Icons.copy,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 30),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              }
            },
            child: const Text('Buy'),
          ),
        ),
      ],
    );
  }
}
