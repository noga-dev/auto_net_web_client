import 'dart:convert';
import 'dart:js_util';
import 'package:http/http.dart';
import 'package:auto_net/utils/common.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:flutter_web3_provider/ethers.dart';
import 'package:web3dart/web3dart.dart';
import '../contracts/user.g.dart';

class Human {
  User? user;
  EtherAmount? walletBalance;
  EtherAmount? contractBalance;
  bool creatingContract = false;
  String? contractAddress;
  Web3Provider? web3;
  Map<String, double> assets = {};
  late Web3Client web3infura = Web3Client(infuraUrl, Client());

  List<String> sourceAbi = [
    'function allProjects() view returns(address[])',
    'function projects(address) view returns (address)',
    'function users(address) view returns (address)',
    'function createUser() returns(address)',
    'function buy() payable'
  ];

  List<String> userAbi = [
    'function balanceATN() view returns (uint256)',
    'function getAssets() view returns (tuple(address,uint256)[])',
    'function createProject(string, string, string, string, string) '
  ];

  Future<bool> web3sign() async {
    var selectedAddress = ethereum!.selectedAddress;
    web3 = Web3Provider(ethereum!);
    var getBalance = web3!.getBalance(ethereum!.selectedAddress);
    var catAre = await promiseToFuture(getBalance);
    var sourceContract = Contract(sourceAddress, sourceAbi, web3);
    var first = await callMethod(sourceContract, 'users', [selectedAddress]);
    var ponse = await promiseToFuture(first);
    dynamic tonse;
    if (!ponse.toString().contains('000000')) {
      contractAddress = ponse.toString();
      var userContract = Contract(ponse.toString(), userAbi, web3);
      var firstAndAHaldf = await callMethod(userContract, 'balanceATN', []);
      tonse = await promiseToFuture(firstAndAHaldf);
      // print('from conse we have $tonse');
      walletBalance = EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        BigInt.parse(tonse.toString()),
      );
      var second = await callMethod(userContract, 'getAssets', []);
      var donse = await promiseToFuture(second);
      for (var asset in donse) {
        // print('found project for user');
        // print('asset zero ${asset[0]}');
        // print('asset one ${asset[1]}');
        assets[asset[0].toString()] = double.parse(asset[1].toString());
      }
    }

    walletBalance = EtherAmount.fromUnitAndValue(
      EtherUnit.wei,
      BigInt.parse(catAre.toString()),
    );
    if (!ponse.toString().contains('000000')) {
      // user =User(address: ponse.toString(), user: us3r, assets: assets);
      user = User(
          address: EthereumAddress.fromHex(ponse.toString()),
          client: web3infura);
      contractBalance = EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        BigInt.parse(tonse.toString()),
      );
    }
    return true;
  }

  Future<String> buyATN(EtherAmount amount) async {
    creatingContract = true;
    var sourceContract = Contract(sourceAddress, sourceAbi, web3);
    sourceContract = sourceContract.connect(web3!.getSigner());
    final transaction = await promiseToFuture(
      callMethod(
        sourceContract,
        'buy',
        [TxParams(value: amount.getInWei.toString())],
      ),
    );
    final hash = json.decode(stringify(transaction))['hash'];
    final result =
        await promiseToFuture(callMethod(web3!, 'waitForTransaction', [hash]));
    if (json.decode(stringify(result))['status'] == 0) {
      creatingContract = false;
      throw Exception('something went wrong.');
    } else {
      var a = json.decode(stringify(result));
      creatingContract = false;
      return a.toString();
    }
  }

  void createProject(name, github, description) async {
    // print("We're creating the new project");
    // print('contract address: $contractAddress');
    // web3 = Web3Provider(ethereum!);
    var userContract = Contract(contractAddress!, userAbi, web3);
    // print('user Contract:$userContract');
    var connectedUserContract = userContract.connect(web3!.getSigner());
    // var firstAndAHaldf = await callMethod(userContract, 'createProject', [
    await callMethod(connectedUserContract, 'createProject', [
      name,
      description,
      github,
      'https://i.ibb.co/2dphSM9/cogs.png',
      'Natural Language'
    ]);
    // var tonse = await promiseToFuture(firstAndAHaldf);
    // print('from conse we have $tonse');
  }
}
