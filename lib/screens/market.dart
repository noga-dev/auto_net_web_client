import 'package:auto_net/screens/market/project_card.dart';
import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'market/project_card.dart';

class Market extends HookWidget {
  const Market({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chainProvider);
    final useProjects = useState(<Widget>[]);

    return FutureBuilder(
      future: useChain.populate(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          if (!(snap.data as bool)) {
            return const Center(child: Text('Failed to fetch data'));
          } else {
            if (useProjects.value.isEmpty) {
              for (var project in useChain.projects) {
                useProjects.value.add(ProjectCard(project: project));
              }
            }
            return SingleChildScrollView(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Wrap(
                    runSpacing: 10,
                    spacing: 7,
                    children: useProjects.value,
                  ),
                ),
              ),
            );
            // GridView.count(
            //   mainAxisSpacing: 20,
            //   crossAxisSpacing: 20,
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 80,
            //     vertical: 20,
            //   ),
            //   crossAxisCount: useProjects.value.length % 2 == 0 ? 2 : 3,
            //   children: useProjects.value,
            // );
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
