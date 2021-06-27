import 'package:auto_net/models/project.dart';
import '../services/chain.dart';

String getShortAddress(String address) =>
    '${address.substring(0, 6)}...${address.substring(address.length - 4)}';

const String sourceAddress = '0x18A4d5A9039fd15A6576896cd7B445f9e4F3cff1';
const String infuraUrl =
    'https://rinkeby.infura.io/v3/e697a6a0ac0a4a7b94b09c88770f14e6';

List<Project> projects = [];

