import 'package:auto_net/components/project_view.dart';
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import '../services/chain.dart';

class Market extends HookWidget {
  Market({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chain);
    return useChain.state.populating?CircularProgressIndicator():Text("Done");
  }
}


// class Market extends StatelessWidget {
//   Market({ Key? key }) : super(key: key);
//   static String route = "/market";
//   List<Widget> projects=[]; 
//   @override
//   Widget build(BuildContext context) {
//      for (Project p in chain.projects){
//        projects.add(ProjectCard(p: p));
//      }
//     return 
      
      
//     //   Container(
//     //   child: Column(children: projects)
//     // );
//   }
// }