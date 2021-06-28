import 'package:auto_net/screens/project_details.dart';
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectView extends HookWidget {
  const ProjectView({Key? key}) : super(key: key);

  // final String address;
  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chain);

    Project? project = (ModalRoute.of(context)?.settings.arguments as Project);

    // ignore: unnecessary_null_comparison
    if (project == null) {
      try {
        project = ModalRoute.of(context)?.settings.arguments as Project;
      } catch (e) {
        project = Project(
          address: 'addr123',
          category: 'cat123',
          description: 'desc123',
          github: 'git123',
          name: 'name123',
          imgUrl: 'pic123',
          mature: true,
        );
      }
    } else {
      for (var item in useChain.state.projects) {
        if (project?.address == item.address) {
          project = item;
        }
      }
      if (project == null) {
        return const SizedBox(
          child: Center(
            child: Text('No such resource on Autonet.'),
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Scrollbar(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 30,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      ProjectDetails(project: project),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Opacity(
            opacity: 0.91,
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border(
                  bottom: BorderSide(
                    width: 0.3,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    TextButtonPlaceholder(
                      text: 'Production',
                    ),
                    TextButtonPlaceholder(text: 'Training'),
                    TextButtonPlaceholder(
                      text: 'Developers',
                    ),
                    TextButtonPlaceholder(
                      text: 'FILTER',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextButtonPlaceholder extends StatelessWidget {
  const TextButtonPlaceholder({
    Key? key,
    this.text,
  }) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        text ?? '',
        style: const TextStyle(
          fontFamily: 'OCR-A',
        ),
      ),
    );
  }
}
