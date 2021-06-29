import 'package:auto_net/components/project_card.dart';
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class ProjectDetailsWrapper extends HookWidget {
  const ProjectDetailsWrapper({
    Key? key,
    required this.projectAddress,
  }) : super(key: key);

  final String projectAddress;

  @override
  Widget build(BuildContext context) {
    final useChain = useProvider(chainProvider);

    for (var project in useChain.projects) {
      if (projectAddress.contains(project.address!)) {
        return ProjectDetails(project: project);
      }
    }

    return ProjectDetails(project: mockProject);
  }
}

// ignore: must_be_immutable
class ProjectDetails extends StatefulWidget {
  ProjectDetails({
    Key? key,
    this.project,
  }) : super(key: key);

  late Project? project;

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  final bool seia = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView(
          children: [
            const SizedBox(height: 11),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: 120, minWidth: 120),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(11.0),
                          child: isValidImageExtension(widget.project!.imgUrl!)
                              ? Image.network(
                                  widget.project!.imgUrl!,
                                )
                              : const Placeholder(),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.project!.name!,
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('Category'),
                                Text('Developer:'),
                                Text('Size Goal:'),
                                Text('Earned:'),
                              ],
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Natural Language'),
                                Text('Alphabet inc'),
                                Text('56BN params'),
                                Text('-- ATN'),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 40),
                  child: Card(
                    elevation: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: const [
                          Text('Price per call'),
                          Text(
                            '0.0031 ATN',
                            style: TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            DefaultTabController(
              length: 3,
              child: SizedBox(
                // height: 400,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  children: [
                    SizedBox(
                      width: 400,
                      child: TabBar(
                        tabs: [
                          const Tab(
                            text: 'About',
                          ),
                          Tab(
                            text: widget.project?.mature ?? true
                                ? 'Hire'
                                : 'Invest',
                          ),
                          const Tab(
                            text: 'Stats',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(50),
                            child: FutureBuilder(
                              future: http.get(
                                Uri.https(
                                  'raw.githubusercontent.com',
                                  '${widget.project?.github?.split('github.com/')[1]}/master/README.md',
                                ),
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState !=
                                    ConnectionState.done) {
                                  return const Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: SizedBox(
                                        width: 100,
                                        height: 120,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  );
                                } else {
                                  return SafeArea(
                                    child: Markdown(
                                      data: (snapshot.data as http.Response)
                                          .body
                                          .toString(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          widget.project?.mature ?? true
                              ? Hire(
                                  project: widget.project!,
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(30),
                                  child: AgentProgress(),
                                ),
                          const Icon(Icons.bar_chart_outlined, size: 350),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Hire extends StatelessWidget {
  const Hire({Key? key, required this.project}) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('RPC Endpoint:'),
                    Text('Access token:'),
                  ],
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ec2-35-178-211-27.eu-west-2.compute.amazonaws.com:5000/v1/${project.address}',
                    ),
                    const Text('Xan499F'),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AgentProgress extends StatelessWidget {
  const AgentProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SizedBox(height: 18),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Current value:'),
                        Text('Funding goal:'),
                        Text('Available shares:'),
                        Text('Price per share:'),
                        Text('Campaign deadline:'),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('341 ATN'),
                        Text('449104 ATN'),
                        Text('9831103 (84.65%)'),
                        Text('0.022 ATN'),
                        Text('May 22, 2021'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton.icon(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(.8),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Container(
                        width: 600,
                        height: 600,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Available funds your contract:',
                                ),
                                SizedBox(width: 9),
                                Text(
                                  '3124 ATN',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: 110,
                              child: TextFormField(
                                style: const TextStyle(fontSize: 19),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: false),
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                  labelText: 'Enter Value',
                                  alignLabelWithHint: true,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 70,
                                  ),
                                  child: const Text(
                                    // ignore: lines_longer_than_80_chars
                                    "You are acquiring shares in project GPT-3. This transaction is irrevocable. You may put up your shares for sale once the training is complete, and you will be reimbursed if the model doesn't achieve the targeted accuracy within the specified timeframe.",
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: 290,
                                  height: 50,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xff851339),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'COMMIT TO BLOCKCHAIN',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.school),
                  label: const Text(
                    'INVEST IN TRAINING',
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
