import 'package:auto_net/components/project_card.dart';
import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/project_card.dart';

class Market extends HookWidget {
  const Market({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chain);
    final useProjects = useState(<Widget>[]);

    print('P: ${useChain.state.projects.length}');
    return FutureBuilder(
      future: useChain.state.populate(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const CircularProgressIndicator();
        } else {
          if (!(snap.data as bool)) {
            return const Text('FALSE');
          } else {
            if (useProjects.value.isEmpty) {
              for (var project in useChain.state.projects) {
                useProjects.value.add(ProjectCard(project: project));
              }
            }
            return Center(
              child: ListView(
                children: useProjects.value,
              ),
            );
          }
        }
      },
    );
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