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
  EtherAmount? userBalance;
  EtherAmount? balance;
  EtherAmount? contractBalance;
  bool creatingContract = false;
  String? contractAddress;
  late Web3Provider web3;
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

  Future<String> buyATN(EtherAmount amount) async {
    creatingContract = true;
    var sourceContract = Contract(contractAddress!, sourceAbi, web3);
    sourceContract = sourceContract.connect(web3.getSigner());
    final transaction = await promiseToFuture(callMethod(
        sourceContract, 'buy', [TxParams(value: amount.getInWei.toString())]));
    final hash = json.decode(stringify(transaction))['hash'];
    final result =
        await promiseToFuture(callMethod(web3, 'waitForTransaction', [hash]));
    if (json.decode(stringify(result))['status'] == 0) {
      creatingContract = false;
      throw Exception('something went wrong.');
    } else {
      var a = json.decode(stringify(result));
      creatingContract = false;
      return a.toString();
    }
  }

  // ignore: always_declare_return_types
  createContract() async {
    var sourceContract = Contract(sourceAddress, sourceAbi, web3);
    sourceContract = sourceContract.connect(web3.getSigner());
    final transaction =
        // ignore: lines_longer_than_80_chars
        await promiseToFuture(callMethod(sourceContract, 'createUser',
            [ethereum?.selectedAddress.toString()]));
    // ignore: avoid_dynamic_calls
    final hash = json.decode(stringify(transaction))['hash'];
    // ignore: prefer_interpolation_to_compose_strings
    print('hash ' + hash.toString());
    final result =
        await promiseToFuture(callMethod(web3, 'waitForTransaction', [hash]));
    // ignore: avoid_dynamic_calls
    if (json.decode(stringify(result))['status'] == 0) {
      throw Exception('something went so wrong.');
    } else {
      print(json.decode(stringify(result)));
      var first = await callMethod(sourceContract, 'users', []);
      print('second $first');
      var ponse = await promiseToFuture(first);
      print('new contract address $ponse');
      user = User(
        address: EthereumAddress.fromHex(ponse.toString()),
        client: web3infura,
      );
    }
  }

  // ignore: always_declare_return_types
  web3sign() async {
    var se = ethereum!.selectedAddress;
    print('selectedAddress: $se');
    var web3user = Web3Provider(ethereum!);
    var catAre =
        await promiseToFuture(web3user.getBalance(ethereum!.selectedAddress));
    print('de curiozitate $catAre');
    var sourceContract = Contract(sourceAddress, sourceAbi, web3user);
    var first = await callMethod(sourceContract, 'users', [se]);
    var ponse = await promiseToFuture(first);
    print('user address is $ponse');
    dynamic tonse;
    if (!ponse.toString().contains('000000')) {
      contractAddress = ponse.toString();
      var userContract = Contract(ponse.toString(), userAbi, web3user);
      var firstAndAHaldf = await callMethod(userContract, 'balanceATN', []);
      tonse = await promiseToFuture(firstAndAHaldf);
      print('from conse we have $tonse');
      userBalance = EtherAmount.fromUnitAndValue(
          EtherUnit.wei, BigInt.parse(tonse.toString()));
      var second = await callMethod(userContract, 'getAssets', []);
      var donse = await promiseToFuture(second);
      for (var asset in donse) {
        print('found project for user');
        // ignore: avoid_dynamic_calls
        print('asset zero ${asset[0]}');
        // ignore: avoid_dynamic_calls
        print('asset one ${asset[1]}');
        // ignore: avoid_dynamic_calls
        assets[asset[0].toString()] = double.parse(asset[1].toString());
      }
    }

    balance = EtherAmount.fromUnitAndValue(
        EtherUnit.wei, BigInt.parse(catAre.toString()));
    if (!ponse.toString().contains('000000')) {
      // user =User(address: ponse.toString(), user: us3r, assets: assets);
      user = User(
          address: EthereumAddress.fromHex(ponse.toString()),
          client: web3infura);
      contractBalance = EtherAmount.fromUnitAndValue(
          EtherUnit.wei, BigInt.parse(tonse.toString()));
    }
  }

  // ignore: always_declare_return_types
  createProject(name, github, description) async {
    print("We're creating the new project");
    print('contract address: $contractAddress');
    var web3user = Web3Provider(ethereum!);
    var userContract = Contract(contractAddress!, userAbi, web3user);
    print('user Contract:$userContract');
    userContract = userContract.connect(web3user.getSigner());
    var firstAndAHaldf = await callMethod(userContract, 'createProject', [
      name,
      description,
      github,
      'https://i.ibb.co/2dphSM9/cogs.png',
      'Natural Language'
    ]);
    var tonse = await promiseToFuture(firstAndAHaldf);
    print('from conse we have $tonse');
  }
}
