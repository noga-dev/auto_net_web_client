import 'package:auto_net/utils/common.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import '../models/abi.dart';
import '../models/project.dart';



class Chain {
  List<Project> projects = [];
  bool populating = false;
  bool populated = false;
  late List addressesOfProjects;
  late String tokenAddress;
  String chainID = '';
  var apiUrl = infuraUrl;
  final EthereumAddress sourceAddr = EthereumAddress.fromHex(sourceAddress);
  Future populate() async {
    populating = true;
    if (projects.isNotEmpty) {
      print("Projects is not empty");
      populating = false;
      return;
    } else {
      print("Projects was empty");
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
      int counter=0;
      for (var item in addressesOfProjects) {
        counter+=1;
        print("found the project $item and $counter");
        final projAddr = EthereumAddress.fromHex(item.toString());
        final contractProiect = DeployedContract(
            ContractAbi.fromJson(projectAbi, 'Project'), projAddr);
        var detailsf = contractProiect.function('details');
        var details = await ethClient
            .call(contract: contractProiect, function: detailsf, params: []);
        // String name = details[0];
        // String desc = details[1];
        var category = details[2].toString().split('http')[0];
        var imgUrl = 'http${details[2].toString().split('http')[1]}';
        var gitLink = 'http${details[2].toString().split('http')[2]}';
        var project = Project(
          address: item.toString(),
          name: details[0].toString(),
          description: details[1].toString(),
          imgUrl: imgUrl,
          category: category,
          github: gitLink,
        );
        projects.add(project);
        // routes['/market/${project.address}'] =
        //     ProjectView(address: project.address, appstate: state);
      }
      populated = true;
      populating=false;
    }
  }
}
