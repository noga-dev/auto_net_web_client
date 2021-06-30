import 'dart:ui';
import 'package:auto_net/components/new_project.dart';
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyContractView extends HookWidget {
  const MyContractView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);
    final useAseturi = useState(<Widget>[]);
    final useChain = useProvider(chainProvider);
    final themeMode = useProvider(themeModeProvider);

    useUser.state.assets.forEach((key, value) {
      for (var p in useChain.state.projects) {
        if (p.address!.toLowerCase() == key.toLowerCase()) {
          useAseturi.value.add(asset(p, value, context));
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
                        ? Colors.black54
                        : Colors.white54,
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
                              Text(
                                'ATN CONTRACT',
                                style: TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 19,
                                  fontFamily: 'Roboto Mono',
                                  letterSpacing: 3,
                                ),
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
                                children: [
                                  const SizedBox(height: 2),
                                  Text(
                                    'address:',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Mono',
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                  const SizedBox(height: 13),
                                  Text(
                                    'liquid funds:',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Mono',
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 18),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(useUser.state.contractAddress!,
                                          style: TextStyle(
                                            fontFamily: 'Roboto Mono',
                                            color:
                                                Theme.of(context).canvasColor,
                                          )),
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
                                                    style:
                                                        TextStyle(fontSize: 20),
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
                                    '${useUser.state.contractBalance!.getInEther} ATN',
                                    style: TextStyle(
                                      fontFamily: 'Roboto Mono',
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const SizedBox(height: 5),
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
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: withdraw(useUser),
                                    ),
                                  ),
                                  child: Text(
                                    'WITHDRAW',
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: 18,
                                    ),
                                  ),
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
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: addFunds(),
                                    ),
                                  ),
                                  child: Text(
                                    'ADD FUNDS',
                                    style: TextStyle(
                                      color: Theme.of(context).canvasColor,
                                      fontSize: 18,
                                    ),
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
                    style: TextStyle(fontSize: 20),
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
                      style: TextStyle(
                        fontSize: 13,
                      ),
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

  Widget withdraw(useUser) {
    // double diff;
    // bool acceptat = false;
    return SizedBox(
      height: 500,
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
// ignore: lines_longer_than_80_chars
            'Contract is currently holding: ${useUser.state.contractBalance.getInEther} ATN',
            style: const TextStyle(fontSize: 19),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Amount to withdraw: ',
                style: TextStyle(fontSize: 19),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  style: const TextStyle(fontSize: 19),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 15),
                    labelText: 'Enter',
                    alignLabelWithHint: true,
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              const Text(
                'ATN',
                style: TextStyle(fontSize: 19),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 290,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {},
              child: const Text(
                'COMMIT TO BLOCKCHAIN',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget addFunds() {
    // double diff;
    // bool acceptat = false;
    return SizedBox(
      height: 500,
      width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            // ignore: prefer_adjacent_string_concatenation
            'Amount available in your wallet: ' +
                // EtherAmount.fromUnitAndValue(
                //         EtherUnit.finney, widget.sc.valoare)
                //     .getValueInUnit(EtherUnit.ether)
                //     .toString() +
                ' ATN',
            style: TextStyle(color: Colors.black87, fontSize: 19),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Amount to add: ',
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                  onChanged: (value) {},
                  maxLines: 1,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                    labelText: 'Enter',
                    alignLabelWithHint: true,
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                  ),
                ),
              ),
              const Text(
                'ATN',
                style: TextStyle(color: Colors.black, fontSize: 19),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: 290,
            height: 50,
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {},
              child: const Text(
                'COMMIT TO BLOCKCHAIN',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget asset(Project p, percent, context) => Container(
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
                      p.name!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 11),
            SizedBox(
              width: 290,
              child: Text(
                p.category!,
                style: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 160,
              child: Text(
                percent.toString(),
                style: const TextStyle(fontSize: 18),
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
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
