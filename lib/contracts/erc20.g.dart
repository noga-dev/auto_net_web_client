// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

class Erc20 extends _i1.GeneratedContract {
  Erc20(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(
            _i1.DeployedContract(
                _i1.ContractAbi.fromJson(
                    '[{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"}],"name":"balanceOf","outputs":[{"name":"balance","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"name":"_owner","type":"address"},{"name":"_spender","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"payable":true,"stateMutability":"payable","type":"fallback"},{"anonymous":false,"inputs":[{"indexed":true,"name":"owner","type":"address"},{"indexed":true,"name":"spender","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"from","type":"address"},{"indexed":true,"name":"to","type":"address"},{"indexed":false,"name":"value","type":"uint256"}],"name":"Transfer","type":"event"}]',
                    'Erc20'),
                address),
            client,
            chainId);

  Future<String> name() async {
    final function = self.function('name');
    final params = [];
    final response = await read(function, params);
    return (response[0] as String);
  }

  Future<String> approve(_i1.EthereumAddress _spender, BigInt _value,
      {required _i1.Credentials credentials}) async {
    final function = self.function('approve');
    final params = [_spender, _value];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<BigInt> totalSupply() async {
    final function = self.function('totalSupply');
    final params = [];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> transferFrom(
      _i1.EthereumAddress _from, _i1.EthereumAddress _to, BigInt _value,
      {required _i1.Credentials credentials}) async {
    final function = self.function('transferFrom');
    final params = [_from, _to, _value];
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

  Future<BigInt> balanceOf(_i1.EthereumAddress _owner) async {
    final function = self.function('balanceOf');
    final params = [_owner];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> symbol() async {
    final function = self.function('symbol');
    final params = [];
    final response = await read(function, params);
    return (response[0] as String);
  }

  Future<String> transfer(_i1.EthereumAddress _to, BigInt _value,
      {required _i1.Credentials credentials}) async {
    final function = self.function('transfer');
    final params = [_to, _value];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<BigInt> allowance(
      _i1.EthereumAddress _owner, _i1.EthereumAddress _spender) async {
    final function = self.function('allowance');
    final params = [_owner, _spender];
    final response = await read(function, params);
    return (response[0] as BigInt);
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

class Transfer {
  Transfer(List<dynamic> response)
      : from = (response[0] as _i1.EthereumAddress),
        to = (response[1] as _i1.EthereumAddress),
        value = (response[2] as BigInt);

  final _i1.EthereumAddress from;

  final _i1.EthereumAddress to;

  final BigInt value;
}
