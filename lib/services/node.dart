import 'dart:async';

import 'package:flutter/material.dart';

class NodeChangeNotifier extends ChangeNotifier {
  // if switch is on, then lock the contract address.
  bool switchValue = false;

  String contractAddress = '';

  Timer? timer;
  int counter = 0;

  final formKey = GlobalKey<FormState>();

  // int? get generatedNumber => _generatedNumber;

  // set min(int x) {
  //   _generatedNumber = null;
  //   _min = x;
  // }

  void changeSwitchValue(bool value) {
    if (value) {
      // if (contractAddress.length != 42) {
      //   print("Alert message");
      // } else {
      switchValue = value;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        print('tick ${timer.tick}');
        counter = timer.tick;
        notifyListeners();
      });
      //}
    } else {
      switchValue = value;
      counter = 0;
      timer?.cancel();
      notifyListeners();
    }

    notifyListeners();
  }
}
