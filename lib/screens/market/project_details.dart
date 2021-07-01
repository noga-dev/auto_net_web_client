// ignore_for_file: cascade_invocations
import 'package:auto_net/screens/market/project_card.dart';
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:auto_net/utils/mock.dart';
import 'package:auto_net/utils/theme.dart';
import 'package:flutter/cupertino.dart';
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
    // final useIsSignedIn = useProvider(isSignedInProvider);

    if (!useChain.state.isPopulated) {
      return FutureBuilder(
        future: useChain.state.populate(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snap.data as bool) {
              for (var project in useChain.state.projects) {
                if (projectAddress.contains(project.address!)) {
                  return ProjectDetails(project: project);
                }
              }
            }
          }
          return const Center(child: Text('Error'));
        },
      );
    }

    for (var project in useChain.state.projects) {
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
                        ),
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
                ),
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
                                      styleSheet:
                                          getMarkdownStyleSheet(context),
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

class Hire extends HookWidget {
  const Hire({Key? key, required this.project}) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(userProvider);
    // final userAddress = useState(ethereum?.selectedAddress);
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 590,
            height: 190,
            child: Card(
                elevation: 3.0,
                // padding:EdgeInsets.all(30),
                // decoration: BoxDecoration(border:Border.all(width: 1)),
                child: SizedBox(
                    height: 370,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          'PROGRAMMATIC ACCESS',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 19),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('RPC Endpoint: '),
                            const SizedBox(width: 30),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 300,
                                      child: Text(
                                        'ec2-35-178-211-27.eu-west-2.compute.amazonaws.com:5000/v1/${project.address}',
                                        style: const TextStyle(fontSize: 9),
                                      )),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Icon(Icons.copy),
                                  )
                                ])
                          ],
                        ),
                        const SizedBox(height: 11),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Access token: '),
                            const SizedBox(width: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: useUser.state.user != null
                                      ? const Text(
                                          'Xm8fwd8411G9A7',
                                          style: TextStyle(fontSize: 9),
                                        )
                                      : const Text(
                                          '(Sign in and create a contract)',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: useUser.state.user != null
                                      ? const Icon(Icons.copy)
                                      : const SizedBox(
                                          width: 20,
                                        ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ))),
          ),
          const SizedBox(height: 19),
          Container(
            padding: const EdgeInsets.all(13),
            child: Interact(
              which: project.name == 'GPT-3' ? 'nlp' : 'chat',
            ),
          ),
        ],
      ),
    );
  }
}

class Entity {
  Entity({required this.name, required this.type});
  late String name;
  late String type;
  Widget view() {
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 200, child: Text('Name: $name')),
          const SizedBox(width: 10),
          SizedBox(width: 250, child: Text('Type: $type')),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Interact extends StatefulWidget {
  Interact({Key? key, required this.which}) : super(key: key);

  final String nlpUrl = 'https://discord-ro.tk:5000/v1/nlp';
  final String chatUrl = 'https://discord-ro.tk:5000/v1/chat';
  final String? which;
  String positive = '';
  String negative = '';
  String mixed = '';
  String neutral = '';
  String aiResponse = '';
  Widget air = Container();
  List<Widget> entities = [];

  @override
  _InteractState createState() => _InteractState();
}

class _InteractState extends State<Interact> {
  var c = TextEditingController();

  List<Widget>? nlp;
  List<Widget>? chat;
  Widget sentiment() {
    return SizedBox(
      width: 600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: const [
            Text('Positive:'),
            Text('Negative:'),
            Text('Mixed:'),
            Text('Neutral:'),
          ]),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.positive),
              Text(widget.negative),
              Text(widget.mixed),
              Text(widget.neutral),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    widget.entities = [];
    super.initState();
    nlp = [
      SizedBox(
          width: 170,
          height: 29,
          child: TextButton(
              onPressed: () async {
                var ha = await nlpRequest(c.text, 'entities');
                ha = ha.replaceAll('\n', '');
                ha = ha.replaceAll(' ', '');
                ha = ha.replaceAll('\\', '');
                var toateNumele = ha.split('Text":');
                var toateTipurile = ha.split('Type":');
                print(toateTipurile);
                var names = [];
                var types = [];
                var n = 0;
                var m = 0;
                for (var a in toateNumele) {
                  m = m + 1;
                  if (m == 1) {
                    continue;
                  }
                  var name = a.split(',')[0];
                  print(name);
                  names.add(name);
                }
                for (var a in toateTipurile) {
                  n = n + 1;
                  if (n == 1) {
                    continue;
                  }
                  var type = a.split('"')[1];
                  types.add(type);
                  widget.entities.add(
                    Entity(name: names[n - 2], type: types[n - 2]).view(),
                  );
                }
                setState(() {
                  widget.air = SizedBox(
                    child: Column(
                      children: widget.entities,
                    ),
                  );
                });
              },
              child: const Text('ENTITIES'))),
      const SizedBox(width: 10),
      SizedBox(
          width: 170,
          height: 29,
          child: TextButton(
              onPressed: () async {
                var ha = await nlpRequest(c.text, 'sentiment');

                setState(() {
                  ha = ha.replaceAll('\n', '');
                  ha = ha.replaceAll(' ', '');
                  ha = ha.split('SentimentScore')[1];
                  print("we're already here");
                  print(ha);
                  widget.negative = ha.split('Negative\\":')[1].split(',')[0];
                  print('negative: ${widget.negative}');
                  print('after the first split');
                  widget.neutral = ha.split('Neutral\\":')[1].split(',')[0];
                  widget.mixed = ha.split('Mixed\\":')[1].split(',')[0];
                  widget.positive =
                      ha.split('Positive\\":')[1].split('\\n}')[0];
                  widget.air = sentiment();
                });
              },
              child: const Text('SENTIMENT'))),
      const SizedBox(width: 10),
      SizedBox(
        width: 170,
        height: 29,
        child: TextButton(
          onPressed: () async {
            var response = await nlpRequest(c.text, 'synthax');
            setState(() {
              widget.aiResponse = response;
            });
          },
          child: const Text(
            'SYNTHAX',
          ),
        ),
      ),
    ];
    chat = [
      SizedBox(
        width: 200,
        height: 29,
        child: TextButton(
          onPressed: () async {
            var response = await chatRequest(c.text, 'appolo');
            setState(() {
              widget.air = Text(
                response,
                style: TextStyle(
                  fontSize: widget.which == 'nlp' ? 14 : 19,
                ),
              );
            });
          },
          child: const Text(
            'SEND MESSAGE',
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    var sc = ScrollController();
    return Scrollbar(
      controller: sc,
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 500,
                height: 150,
                child: TextField(
                  controller: c,
                  maxLines: 5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.which == 'nlp' ? nlp! : chat!,
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: 580,
                child: Center(child: widget.air),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> nlpRequest(text, type) async {
    var querystring = {'text': text, 'type': type};
    var uri = Uri.parse(widget.nlpUrl);

    var resp = await http.get(
      uri.replace(queryParameters: querystring),
    );
    print('What comes back is ${resp.body}');
    return resp.body.toString();
  }

  Future<String> chatRequest(zice, uid) async {
    var querystring = {'zice': zice};
    var uri = Uri.parse(widget.chatUrl);
    var resp = await http.get(
      uri.replace(queryParameters: querystring),
    );
    print('What comes back is ${resp.body.split('"')[3]}');
    return resp.body.split('"')[3];
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
