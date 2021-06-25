import 'package:auto_net/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web3_provider/ethereum.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyAssets extends HookWidget {
  // var number;
  @override
  Widget build(BuildContext context) {
    final userAddress = useState(ethereum?.selectedAddress);
    final number= useState(13);
    final useUser = useState(us3r);
    // final useUser = useProvider(us3r);
    
    return Container(
      child: Column(children: [
        Text(userAddress.value== 'addrError'?'not logged in':userAddress.value!),
        TextButton(
          child:Text("Change number"),
          onPressed: (){
            number.value=5;
          },),
        SizedBox(height:100),
        Text("balance "+useUser.value.balance.toString()),
        Text(useUser.value.user==null?"No contract":"Contract is here"),
        TextButton(child:Text("get the details"),onPressed: (){
          us3r.web3sign();
        },),
      ],) 
      
    );
  }
}

class CreateContractButton extends StatelessWidget {
  const CreateContractButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final useUser = useState(us3r);
    return SizedBox(
      child:Center(child: Text(useUser.value.user==null?"No contract":"Contract is here"))
    );
  }
}