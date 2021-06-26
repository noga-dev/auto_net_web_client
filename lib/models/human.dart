// ignore_for_file: avoid_print
//ignore_for_file: avoid_dynamic_calls

import 'dart:convert';
import 'dart:js_util';
import 'package:auto_net/models/project.dart';
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
  late Web3Provider web3;
  Map<String,double> assets={};
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
  ];

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
      print('second ' + first.toString());
      var ponse = await promiseToFuture(first);
      print('new contract address ' + ponse.toString());
      user = User(
        address: EthereumAddress.fromHex(ponse.toString()),
        client: web3infura,
      );
    }
  }

  web3sign() async {
    String se = ethereum!.selectedAddress;
    print('selectedAddress: $se');
    Web3Provider web3user = Web3Provider(ethereum!);
    var catAre =
        await promiseToFuture(web3user.getBalance(ethereum!.selectedAddress));
    print('de curiozitate ' + catAre.toString());
    String owner = se;
    var sourceContract = Contract(sourceAddress, sourceAbi, web3user);
    var first = await callMethod(sourceContract, 'users', [se]);
    var ponse = await promiseToFuture(first);
    print('user address is ' + ponse.toString());
    var tonse;
    if (!ponse.toString().contains('000000')) {
      var userContract = Contract(ponse.toString(), userAbi, web3user);
      var firstAndAHaldf = await callMethod(userContract, 'balanceATN', []);
      tonse = await promiseToFuture(firstAndAHaldf);
      print('from conse we have $tonse');
    userBalance=EtherAmount.fromUnitAndValue(
        EtherUnit.wei, BigInt.parse(tonse.toString()));
      var second = await callMethod(userContract, 'getAssets', []);
      var donse = await promiseToFuture(second);
      for (var asset in donse) {
        print('found project for user');
        print("asset zero "+asset[0].toString());
        print("asset one "+ asset[1].toString());
        assets[asset[0].toString()] = double.parse(asset[1].toString());
        // assets.putIfAbsent(asset[0].toString(), () => double.parse(asset[1].toString()));
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
}
