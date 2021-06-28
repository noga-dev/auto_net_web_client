import 'package:auto_net/services/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Node extends ConsumerWidget {
  const Node({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final node = watch(nodeProvider);
    final formKey = node.formKey;
    return Center(
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Switch(
                        value: node.switchValue,
                        onChanged: (value) {
                          if (formKey.currentState?.validate() == true) {
                            formKey.currentState?.save();
                            node.changeSwitchValue(value);
                          }

                          print("onChanged ${node.switchValue}");
                          // context.read(nodeProvider).switchValue = value;
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          onChanged: (String s) {
                            formKey.currentState?.validate();
                          },
                          enabled: !node.switchValue,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Contract Address",
                          ),
                          onSaved: (String? value) {
                            var trimmed = (value ?? '').trim();
                            node.contractAddress = trimmed;
                          },
                          validator: (String? value) {
                            if (value == null || value.length != 4) {
                              return 'Enter valid Contract Address';
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Uptime duration: ${value(node.counter)}"),
                    ],
                  ),
                ),
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Column(
              //       children: [
              //         Text('Contract Address'),
              //       ],
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  String value(int c) {
    var d = Duration(seconds: c);
    List<String> parts = d.toString().split(':');
    return '${parts[0]}:${parts[1]}:${parts[2].split('.')[0]}';
  }
}
