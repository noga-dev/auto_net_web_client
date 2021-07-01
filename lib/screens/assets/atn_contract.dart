import 'dart:ui';
import 'package:auto_net/screens/market/new_project.dart';
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: use_key_in_widget_constructors
// ignore: must_be_immutable
// ignore: use_key_in_widget_constructors
class MyContractView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);
    final useAseturi = useState(<Widget>[]);
    final useChain = useProvider(chainProvider);
    final themeMode = useProvider(themeModeProvider);
    final useGetErc20 = useFuture(useMemoized(() => useUser.state.getErc20()));

    useUser.state.assets.forEach((key, value) {
      for (var project in useChain.projects) {
        if (project.address!.toLowerCase() == key.toLowerCase()) {
          useAseturi.value.add(
            _Asset(
              project: project,
              percent: value,
            ),
          );
        }
      }
      print('length ${useAseturi.value.length}');
    });

    return MediaQuery(
      data: const MediaQueryData(textScaleFactor: 1),
      child: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 19),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeMode.state == ThemeMode.light
                      ? Colors.black54
                      : Colors.white54,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    color: themeMode.state == ThemeMode.light
                        ? Colors.black12
                        : Colors.white12,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(width: 14),
                              Image.network(
                                'https://i.ibb.co/kXVw8Z2/logo64x64.png',
                                height: 50,
                              ),
                              const Spacer(),
                              const Text(
                                'ATN CONTRACT',
                              ),
                              const Spacer(),
                              Image.network(
                                'https://i.ibb.co/kXVw8Z2/logo64x64.png',
                                height: 50,
                              ),
                              const SizedBox(width: 14)
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  SizedBox(height: 2),
                                  Text(
                                    'Address:',
                                  ),
                                  SizedBox(height: 13),
                                  Text(
                                    'Liquid funds:',
                                  ),
                                ],
                              ),
                              const SizedBox(width: 18),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        useUser.state.contractAddress!,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Clipboard.setData(
                                            ClipboardData(
                                              text: useUser
                                                  .state.contractAddress!,
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              duration:
                                                  Duration(milliseconds: 1600),
                                              content: SizedBox(
                                                height: 70,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    // ignore: lines_longer_than_80_chars
                                                    'Contract address was copied to cliboard.',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.copy,
                                          color: Theme.of(context).canvasColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    // ignore: lines_longer_than_80_chars
                                    '${useGetErc20.data.toString()} ATN',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                width: 210,
                                height: 40,
                                child: TextButton(
                                  style: getButtonStyle(context),
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: _Withdraw(
                                        erc20data: useGetErc20.data.toString(),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Withdraw'),
                                ),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                                width: 210,
                                height: 40,
                                child: TextButton(
                                  style: getButtonStyle(context),
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: _Deposit(
                                        erc20data: useGetErc20.data.toString(),
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Deposit',
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'PORTFOLIO',
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: const Text('AGENT NAME'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: const Text('CATEGORY'),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: const Text('SHARES OWNED'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: useAseturi.value,
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.transparent,
                      ),
                    ),
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
                    child: const Text(
                      'Developing in TensorFlow? Add your project.',
                    ),
                  ),
                  const SizedBox(height: 7)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _Withdraw extends HookWidget {
  const _Withdraw({Key? key, required this.erc20data}) : super(key: key);

  final String erc20data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            // ignore: lines_longer_than_80_chars
            'Contract is currently holding: $erc20data ATN',
            // ignore: lines_longer_than_80_chars
            // 'Contract is currently holding: ${useUser.state.contractBalance!.getInEther} ATN',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Amount to withdraw: '),
              SizedBox(
                width: 100,
                child: TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Enter',
                    alignLabelWithHint: true,
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              const Text('ATN'),
            ],
          ),
          SizedBox(
            width: 290,
            height: 50,
            child: TextButton(
              style: getButtonStyle(context),
              onPressed: () {},
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Asset extends HookWidget {
  const _Asset({Key? key, this.project, this.percent}) : super(key: key);

  final Project? project;
  final dynamic percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 30),
          SizedBox(
            width: 230,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    project!.name!,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 11),
          SizedBox(
            width: 290,
            child: Text(
              project!.category!,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 160,
            child: Text(
              percent.toString(),
            ),
          ),
          SizedBox(
            width: 100,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'SELL',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Deposit extends HookWidget {
  const _Deposit({Key? key, required this.erc20data}) : super(key: key);

  final String erc20data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            // ignore: lines_longer_than_80_chars
            'Amount available in your wallet: $erc20data ATN',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Amount to add: ',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: 100,
                  child: TextField(
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                    maxLines: 1,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: 'Enter',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
              const Text('ATN'),
            ],
          ),
          SizedBox(
            width: 290,
            height: 50,
            child: TextButton(
              style: getButtonStyle(context),
              onPressed: () {},
              child: const Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }
}
