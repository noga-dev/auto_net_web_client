// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;
import 'dart:typed_data' as _i2;

class Token extends _i1.GeneratedContract {
  Token(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(
            _i1.DeployedContract(
                _i1.ContractAbi.fromJson(
                    '[{"inputs":[],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":true,"internalType":"address","name":"tokenHolder","type":"address"}],"name":"AuthorizedOperator","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"bytes","name":"data","type":"bytes"},{"indexed":false,"internalType":"bytes","name":"operatorData","type":"bytes"}],"name":"Burned","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"bytes","name":"data","type":"bytes"},{"indexed":false,"internalType":"bytes","name":"operatorData","type":"bytes"}],"name":"Minted","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":true,"internalType":"address","name":"tokenHolder","type":"address"}],"name":"RevokedOperator","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"operator","type":"address"},{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"bytes","name":"data","type":"bytes"},{"indexed":false,"internalType":"bytes","name":"operatorData","type":"bytes"}],"name":"Sent","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"inputs":[{"internalType":"address","name":"holder","type":"address"},{"internalType":"address","name":"spender","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"value","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"operator","type":"address"}],"name":"authorizeOperator","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"tokenHolder","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"bytes","name":"data","type":"bytes"}],"name":"burn","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"pure","type":"function"},{"inputs":[],"name":"defaultOperators","outputs":[{"internalType":"address[]","name":"","type":"address[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"granularity","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"imprima","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"operator","type":"address"},{"internalType":"address","name":"tokenHolder","type":"address"}],"name":"isOperatorFor","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"bytes","name":"data","type":"bytes"},{"internalType":"bytes","name":"operatorData","type":"bytes"}],"name":"operatorBurn","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"bytes","name":"data","type":"bytes"},{"internalType":"bytes","name":"operatorData","type":"bytes"}],"name":"operatorSend","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"operator","type":"address"}],"name":"revokeOperator","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"bytes","name":"data","type":"bytes"}],"name":"send","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"holder","type":"address"},{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"}]',
                    'Token'),
                address),
            client,
            chainId);

  Future<BigInt> allowance(
      _i1.EthereumAddress holder, _i1.EthereumAddress spender) async {
    final function = self.function('allowance');
    final params = [holder, spender];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> approve(_i1.EthereumAddress spender, BigInt value,
      {required _i1.Credentials credentials}) async {
    final function = self.function('approve');
    final params = [spender, value];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> authorizeOperator(_i1.EthereumAddress operator,
      {required _i1.Credentials credentials}) async {
    final function = self.function('authorizeOperator');
    final params = [operator];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<BigInt> balanceOf(_i1.EthereumAddress tokenHolder) async {
    final function = self.function('balanceOf');
    final params = [tokenHolder];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> burn(BigInt amount, _i2.Uint8List data,
      {required _i1.Credentials credentials}) async {
    final function = self.function('burn');
    final params = [amount, data];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<BigInt> decimals() async {
    final function = self.function('decimals');
    final params = [];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<List<_i1.EthereumAddress>> defaultOperators() async {
    final function = self.function('defaultOperators');
    final params = [];
    final response = await read(function, params);
    return (response[0] as List<dynamic>).cast<_i1.EthereumAddress>();
  }

  Future<BigInt> granularity() async {
    final function = self.function('granularity');
    final params = [];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> imprima(BigInt amount,
      {required _i1.Credentials credentials}) async {
    final function = self.function('imprima');
    final params = [amount];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<bool> isOperatorFor(
      _i1.EthereumAddress operator, _i1.EthereumAddress tokenHolder) async {
    final function = self.function('isOperatorFor');
    final params = [operator, tokenHolder];
    final response = await read(function, params);
    return (response[0] as bool);
  }

  Future<String> name() async {
    final function = self.function('name');
    final params = [];
    final response = await read(function, params);
    return (response[0] as String);
  }

  Future<String> operatorBurn(_i1.EthereumAddress account, BigInt amount,
      _i2.Uint8List data, _i2.Uint8List operatorData,
      {required _i1.Credentials credentials}) async {
    final function = self.function('operatorBurn');
    final params = [account, amount, data, operatorData];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> operatorSend(
      _i1.EthereumAddress sender,
      _i1.EthereumAddress recipient,
      BigInt amount,
      _i2.Uint8List data,
      _i2.Uint8List operatorData,
      {required _i1.Credentials credentials}) async {
    final function = self.function('operatorSend');
    final params = [sender, recipient, amount, data, operatorData];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> revokeOperator(_i1.EthereumAddress operator,
      {required _i1.Credentials credentials}) async {
    final function = self.function('revokeOperator');
    final params = [operator];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> send(
      _i1.EthereumAddress recipient, BigInt amount, _i2.Uint8List data,
      {required _i1.Credentials credentials}) async {
    final function = self.function('send');
    final params = [recipient, amount, data];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> symbol() async {
    final function = self.function('symbol');
    final params = [];
    final response = await read(function, params);
    return (response[0] as String);
  }

  Future<BigInt> totalSupply() async {
    final function = self.function('totalSupply');
    final params = [];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> transfer(_i1.EthereumAddress recipient, BigInt amount,
      {required _i1.Credentials credentials}) async {
    final function = self.function('transfer');
    final params = [recipient, amount];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> transferFrom(
      _i1.EthereumAddress holder, _i1.EthereumAddress recipient, BigInt amount,
      {required _i1.Credentials credentials}) async {
    final function = self.function('transferFrom');
    final params = [holder, recipient, amount];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  /// Returns a live stream of all Approval events emitted by this contract.
  Stream<Approval> approvalEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Approval');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Approval(decoded);
    });
  }

  /// Returns a live stream of all AuthorizedOperator events emitted by this contract.
  Stream<AuthorizedOperator> authorizedOperatorEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('AuthorizedOperator');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return AuthorizedOperator(decoded);
    });
  }

  /// Returns a live stream of all Burned events emitted by this contract.
  Stream<Burned> burnedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Burned');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Burned(decoded);
    });
  }

  /// Returns a live stream of all Minted events emitted by this contract.
  Stream<Minted> mintedEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Minted');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Minted(decoded);
    });
  }

  /// Returns a live stream of all RevokedOperator events emitted by this contract.
  Stream<RevokedOperator> revokedOperatorEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('RevokedOperator');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return RevokedOperator(decoded);
    });
  }

  /// Returns a live stream of all Sent events emitted by this contract.
  Stream<Sent> sentEvents({_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Sent');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Sent(decoded);
    });
  }

  /// Returns a live stream of all Transfer events emitted by this contract.
  Stream<Transfer> transferEvents(
      {_i1.BlockNum? fromBlock, _i1.BlockNum? toBlock}) {
    final event = self.event('Transfer');
    final filter = _i1.FilterOptions.events(
        contract: self, event: event, fromBlock: fromBlock, toBlock: toBlock);
    return client.events(filter).map((_i1.FilterEvent result) {
      final decoded = event.decodeResults(result.topics!, result.data!);
      return Transfer(decoded);
    });
  }
}

class Approval {
  Approval(List<dynamic> response)
      : owner = (response[0] as _i1.EthereumAddress),
        spender = (response[1] as _i1.EthereumAddress),
        value = (response[2] as BigInt);

  final _i1.EthereumAddress owner;

  final _i1.EthereumAddress spender;

  final BigInt value;
}

class AuthorizedOperator {
  AuthorizedOperator(List<dynamic> response)
      : operator = (response[0] as _i1.EthereumAddress),
        tokenHolder = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress operator;

  final _i1.EthereumAddress tokenHolder;
}

class Burned {
  Burned(List<dynamic> response)
      : operator = (response[0] as _i1.EthereumAddress),
        from = (response[1] as _i1.EthereumAddress),
        amount = (response[2] as BigInt),
        data = (response[3] as _i2.Uint8List),
        operatorData = (response[4] as _i2.Uint8List);

  final _i1.EthereumAddress operator;

  final _i1.EthereumAddress from;

  final BigInt amount;

  final _i2.Uint8List data;

  final _i2.Uint8List operatorData;
}

class Minted {
  Minted(List<dynamic> response)
      : operator = (response[0] as _i1.EthereumAddress),
        to = (response[1] as _i1.EthereumAddress),
        amount = (response[2] as BigInt),
        data = (response[3] as _i2.Uint8List),
        operatorData = (response[4] as _i2.Uint8List);

  final _i1.EthereumAddress operator;

  final _i1.EthereumAddress to;

  final BigInt amount;

  final _i2.Uint8List data;

  final _i2.Uint8List operatorData;
}

class RevokedOperator {
  RevokedOperator(List<dynamic> response)
      : operator = (response[0] as _i1.EthereumAddress),
        tokenHolder = (response[1] as _i1.EthereumAddress);

  final _i1.EthereumAddress operator;

  final _i1.EthereumAddress tokenHolder;
}

class Sent {
  Sent(List<dynamic> response)
      : operator = (response[0] as _i1.EthereumAddress),
        from = (response[1] as _i1.EthereumAddress),
        to = (response[2] as _i1.EthereumAddress),
        amount = (response[3] as BigInt),
        data = (response[4] as _i2.Uint8List),
        operatorData = (response[5] as _i2.Uint8List);

  final _i1.EthereumAddress operator;

  final _i1.EthereumAddress from;

  final _i1.EthereumAddress to;

  final BigInt amount;

  final _i2.Uint8List data;

  final _i2.Uint8List operatorData;
}

class Transfer {
  Transfer(List<dynamic> response)
      : from = (response[0] as _i1.EthereumAddress),
        to = (response[1] as _i1.EthereumAddress),
        value = (response[2] as BigInt);

  final _i1.EthereumAddress from;

  final _i1.EthereumAddress to;

  final BigInt value;
}
