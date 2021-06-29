import 'package:flutter/material.dart';

String getShortAddress(String address) =>
    '${address.substring(0, 6)}...${address.substring(address.length - 4)}';

const String sourceAddress = '0x18A4d5A9039fd15A6576896cd7B445f9e4F3cff1';
const String infuraUrl =
    'https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6';

final page404 = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text('404', textScaleFactor: 2),
      Divider(color: Colors.transparent),
      Text('Page Not Found'),
    ],
  ),
);

/// Not logged in
final page403 = Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      Text('403', textScaleFactor: 2),
      Divider(color: Colors.transparent),
      Text('Unauthenticated'),
    ],
  ),
);
