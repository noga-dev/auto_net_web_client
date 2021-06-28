import 'package:auto_net/models/project.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 4,
        child: TextButton(
          onPressed: () => Beamer.of(context).beamToNamed(
            '/project/projectAddress=${project.address}',
          ),
          child: SizedBox(
            width: 400,
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 5, 5),
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 90, maxWidth: 90),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: isValidImageExtension(project.imgUrl ?? '')
                              ? Image.network(project.imgUrl ?? '')
                              : const Placeholder(),
                          // child: const Placeholder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.name ?? '',
                            style: const TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: const [Text('******'), Text('\\u200d')],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(19),
                  child: Text(project.description ?? ''),
                ),
              ],
            ),
          ),
        ),
      );
}

const _acceptedImgFormats = [
  'gif',
  'png',
  'jpg',
  'jpeg',
];

bool isValidImageExtension(String string) {
  for (var item in _acceptedImgFormats) {
    if (string.endsWith(item)) {
      return true;
    }
  }
  return false;
}
