import 'package:auto_net/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import '../models/abi.dart';
import '../models/project.dart';

class Chain extends ChangeNotifier {
  List<Project> projects = [];
  bool isPpopulating = false;
  bool isPopulated = false;
  late List addressesOfProjects;
  late String tokenAddress;
  String chainID = '';
  var apiUrl = infuraUrl;
  final EthereumAddress sourceAddr = EthereumAddress.fromHex(sourceAddress);

  void retrieveTokenAddress() async {
    var httpClient = Client();
    var ethClient = Web3Client(apiUrl, httpClient);
    final contractSursa =
        DeployedContract(ContractAbi.fromJson(sourceAbi, 'Source'), sourceAddr);
    var tokaddress = contractSursa.function('tokenAddress');
    var raspunsLaTokenAddress = await ethClient
        .call(contract: contractSursa, function: tokaddress, params: []);
    tokenAddress = raspunsLaTokenAddress[0].toString();
  }

  Future<bool> populate() async {
    isPpopulating = true;
    if (projects.isNotEmpty) {
      // print("Projects is not empty");
      isPpopulating = false;
      return true;
    } else {
      // print("Projects was empty");
      var httpClient = Client();
      var ethClient = Web3Client(apiUrl, httpClient);
      final contractSursa = DeployedContract(
          ContractAbi.fromJson(sourceAbi, 'Source'), sourceAddr);
      var tokaddress = contractSursa.function('tokenAddress');
      var raspunsLaTokenAddress = await ethClient
          .call(contract: contractSursa, function: tokaddress, params: []);
      tokenAddress = raspunsLaTokenAddress[0].toString();
      var proiectef = contractSursa.function('allProjects');
      var allProjects = await ethClient
          .call(contract: contractSursa, function: proiectef, params: []);
      addressesOfProjects = allProjects[0];
      var counter = 0;
      for (var item in addressesOfProjects) {
        // print("found the project $item and ${counter++}");
        // print("found the project $item and $counter");
        final projAddr = EthereumAddress.fromHex(item.toString());
        final contractProiect = DeployedContract(
            ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
        var detailsf = contractProiect.function('details');
        var details = await ethClient
            .call(contract: contractProiect, function: detailsf, params: []);
        // String name = details[0];
        // String desc = details[1];
        var category = details[2].toString().split('http')[0];
        String? imgUrl;
        String? gitLink;
        try {
          imgUrl = 'http${details[2].toString().split('http')[1]}';
        } catch (e) {
          imgUrl = 'https://i.ibb.co/2dphSM9/cogs.png';
        }
        try {
          gitLink = 'http${details[2].toString().split('http')[2]}';
        } catch (e) {
          gitLink = 'https://github.com/openai/gpt-3';
        }
        // if (counter == 3) {
        //   populated = true;
        //   populating = false;
        //   return true;
        // }
        var project = Project(
          address: item.toString(),
          name: details[0].toString(),
          description: details[1].toString(),
          imgUrl: imgUrl,
          mature: counter++ % 2 == 0,
          category: category,
          github: gitLink,
        );
        // print(counter);
        projects.add(project);
        // routes['/market/${project.address}'] =
        //     ProjectView(address: project.address, appstate: state);
      }
      isPopulated = true;
      isPpopulating = false;
      notifyListeners();
      return true;
    }
  }
}
