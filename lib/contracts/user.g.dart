// Generated code, do not modify. Run `build_runner build` to re-generate!
// @dart=2.12
import 'package:web3dart/web3dart.dart' as _i1;

class User extends _i1.GeneratedContract {
  User(
      {required _i1.EthereumAddress address,
      required _i1.Web3Client client,
      int? chainId})
      : super(
            _i1.DeployedContract(
                _i1.ContractAbi.fromJson(
                    '[{"inputs":[{"internalType":"address","name":"adresaLaBanu","type":"address"},{"internalType":"address","name":"adresaLaOwner","type":"address"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"balanceATN","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"balanceETH","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"_name","type":"string"},{"internalType":"string","name":"_description","type":"string"},{"internalType":"string","name":"_code","type":"string"},{"internalType":"string","name":"_iconurl","type":"string"},{"internalType":"string","name":"_category","type":"string"}],"name":"createProject","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"getAssets","outputs":[{"components":[{"internalType":"address","name":"cine","type":"address"},{"internalType":"uint256","name":"ce","type":"uint256"}],"internalType":"struct User.asset[]","name":"","type":"tuple[]"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"assetAddress","type":"address"},{"internalType":"uint64","name":"amount","type":"uint64"}],"name":"sellShares","outputs":[],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"withdraw","outputs":[],"stateMutability":"nonpayable","type":"function"}]',
                    'User'),
                address),
            client,
            chainId);

  Future<BigInt> balanceATN() async {
    final function = self.function('balanceATN');
    final params = [];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<BigInt> balanceETH() async {
    final function = self.function('balanceETH');
    final params = [];
    final response = await read(function, params);
    return (response[0] as BigInt);
  }

  Future<String> createProject(String _name, String _description, String _code,
      String _iconurl, String _category,
      {required _i1.Credentials credentials}) async {
    final function = self.function('createProject');
    final params = [_name, _description, _code, _iconurl, _category];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<List<dynamic>> getAssets() async {
    final function = self.function('getAssets');
    final params = [];
    final response = await read(function, params);
    return (response[0] as List<dynamic>).cast<dynamic>();
  }

  Future<_i1.EthereumAddress> owner() async {
    final function = self.function('owner');
    final params = [];
    final response = await read(function, params);
    return (response[0] as _i1.EthereumAddress);
  }

  Future<String> sellShares(_i1.EthereumAddress assetAddress, BigInt amount,
      {required _i1.Credentials credentials}) async {
    final function = self.function('sellShares');
    final params = [assetAddress, amount];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }

  Future<String> withdraw(BigInt amount,
      {required _i1.Credentials credentials}) async {
    final function = self.function('withdraw');
    final params = [amount];
    final transaction = _i1.Transaction.callContract(
        contract: self, function: function, parameters: params);
    return write(credentials, transaction);
  }
}
