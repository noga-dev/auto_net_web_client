// ignore_for_file: lines_longer_than_80_chars
import 'package:auto_net/models/project.dart';
import 'package:auto_net/services/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

const _textStyle = TextStyle(fontSize: 19, fontWeight: FontWeight.bold);

class TeamMember extends StatelessWidget {
  const TeamMember(
      {Key? key,
      required this.project,
      required this.address,
      required this.percent,
      required this.state})
      : super(key: key);

  final String address;
  final double percent;
  final _EditProjectState state;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(address, style: const TextStyle(fontSize: 13)),
        Row(
          children: [
            SizedBox(
              width: 300,
              child: Slider(
                value: project.team[address]!,
                min: 0,
                max: 100,
                onChanged: (value) {
                  var cati = project.team.keys.length - 1;
                  var sum = .0;
                  project.team.forEach((k, v) {
                    sum = sum + v;
                  });
                  if (project.team.keys.length > 1 && value <= 100 - cati) {
                    var diff = project.team[address]! - value;
                    // ignore: invalid_use_of_protected_member
                    state.setState(
                      () {
                        project.team[address] = value;
                        project.team.forEach(
                          (k, v) {
                            if (k != address) {
                              if ((diff < 0 && project.team[k]! < 1) ||
                                  (diff > 0 && project.team[k]! > 99)) {
                                cati = cati - 1;
                              }
                              if (diff < 0 && project.team[k]! > 1 ||
                                  diff > 0 && project.team[k]! < 99) {
                                project.team[k] =
                                    project.team[k]! + (diff / cati);
                              }
                            }
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Column(
              children: [
                const Text('Team share'),
                Text(
                  percent.toStringAsFixed(1),
                  style: _textStyle,
                ),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              children: [
                const Text('Total share'),
                Text(
                  (percent * (project.split / 100)).toStringAsFixed(2),
                  style: _textStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class EditProject extends StatefulWidget {
  const EditProject({
    Key? key,
    required this.project,
  }) : super(key: key);
  final bool textfield = false;
  final bool filepaste = false;

  final bool socket = false;
  final Project project;
  final String url = 'https://discord-ro.tk:5000/v1/post_image';

  @override
  _EditProjectState createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  String? rootPath;
  List<Widget> ownership = [];
  bool textfield = false;
  bool filepaste = false;
  bool socket = false;

  @override
  void initState() {
    super.initState();
    textfield = widget.textfield;
    filepaste = widget.filepaste;
    socket = widget.socket;
  }

  @override
  Widget build(BuildContext context) {
    ownership = [];
    for (var stakeholder in widget.project.team.keys) {
      ownership.add(TeamMember(
        project: widget.project,
        percent: widget.project.team[stakeholder]!.toDouble(),
        state: this,
        address: stakeholder,
      ));
    }
    return Scrollbar(
      child: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.8,
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black)),
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          const Text(
            'Add new AI project',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 49),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 140,
                width: 179,
                child: Image.network('https://i.ibb.co/2dphSM9/cogs.png',
                    height: 120),
              ),
              const SizedBox(width: 50),
              Column(
                children: [agentName(), agentDescription()],
              )
            ],
          ),
          const SizedBox(height: 20),
          linkGit()
        ]),
      )),
    );
  }

  Widget stillLinkGit() {
    var textEditingController = TextEditingController();
    return SizedBox(
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(Icons.warning, color: Colors.red),
            Text(
              '  MIND THE FORMAT  ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
            ),
            Icon(Icons.warning, color: Colors.red)
          ]),
          const SizedBox(height: 19),
          const SizedBox(
            width: 400,
            child: Text(
              'To ensure compatibility in both training and production environments, Autonet projects need a standardized codebase. As best practice, we recommend cloning the template project and adding your custom logic to it. Make sure your repo is implementing all required methods before committing it to the blockchain:',
            ),
          ),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              SizedBox(
                width: 400,
                height: 30,
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Paste link to repository',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.project.github = textEditingController.text;
              });

              Navigator.of(context).pop();
            },
            child: const SizedBox(
              width: 130,
              height: 30,
              child: Center(
                child: Text('DONE'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget linkGit() {
    var team = <Widget>[];
    widget.project.team.forEach(
      (key, value) => team.add(
        TeamMember(
            address: key,
            percent: value.toDouble(),
            project: widget.project,
            state: this),
      ),
    );
    if (widget.project.github == null) {
      return Container(
        margin: const EdgeInsets.all(50),
        child: TextButton(
          onPressed: () {},
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).buttonColor, elevation: 1),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: stillLinkGit(),
                ),
              );
            },
            child: Container(
              width: 290,
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.code),
                  SizedBox(width: 7),
                  Text(
                    'Link Code Repository',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return DefaultTabController(
        length: 3,
        child: SizedBox(
          // height: 400,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              const SizedBox(
                width: 400,
                child: TabBar(
                  tabs: [
                    Tab(text: 'About'),
                    Tab(text: 'Client I/O'),
                    Tab(text: 'Ownership'),
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
                            '${widget.project.github!.split('github.com/')[1]}/master/README.md',
                          ),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                padding: const EdgeInsets.only(top: 20),
                                width: 100,
                                height: 120,
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          } else {
                            return SafeArea(
                              child: Markdown(
                                  data: (snapshot.data as http.Response)
                                      .body
                                      .toString()),
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                    width: 500,
                                    child: Text(
                                        'Your model will be invoked through RPC calls. Select the additional in/out types to be made available through the web and native clients.')),
                                const SizedBox(height: 35),
                                SizedBox(
                                  width: 390,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              value: widget.textfield,
                                              checkColor:
                                                  Theme.of(context).errorColor,
                                              onChanged: (value) {
                                                setState(() {
                                                  textfield = value!;
                                                });
                                              }),
                                          const SizedBox(width: 10),
                                          const Text('Text field copy/paste')
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              checkColor:
                                                  Theme.of(context).errorColor,
                                              value: widget.filepaste,
                                              onChanged: (value) {
                                                setState(() {
                                                  filepaste = value!;
                                                });
                                              }),
                                          const SizedBox(width: 10),
                                          const Text('File upload/download')
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              checkColor:
                                                  Theme.of(context).errorColor,
                                              value: widget.socket,
                                              onChanged: (value) {
                                                setState(() {
                                                  socket = value!;
                                                });
                                              }),
                                          const SizedBox(width: 10),
                                          const Text('Direct socket connection')
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          width: 480,
                          child: const Text(
                            'The dev/founding team can be allocated a maximum of 9% of the revenue generated by the mature agent, and that can be split between any number of Autonet contracts.',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              const Text(
                                'Distribution of revenue between devs and investors:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 390,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const Text('Devs'),
                                        Text(
                                          widget.project.split
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                        width: 280,
                                        child: Slider(
                                          min: 0.1,
                                          max: 9.0,
                                          divisions: 90,
                                          value: widget.project.split,
                                          onChanged: (value) {
                                            setState(() {
                                              widget.project.split = value;
                                            });
                                          },
                                        )),
                                    Column(
                                      children: [
                                        const Text('Investors'),
                                        Text(
                                          (100.0 - widget.project.split)
                                              .toStringAsFixed(1),
                                          style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.all(25),
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Column(
                            children: [
                              const Text(
                                'Distribution of revenue among founding team:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20),
                              Column(children: ownership),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: SizedBox(
                                          height: 240,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 10),
                                              const Text('Add team member',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14)),
                                              const SizedBox(height: 40),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 100),
                                                child: TextField(
                                                  maxLength: 42,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'Paste Ethereum wallet address (starting with 0x)',
                                                  ),
                                                  maxLines: 1,
                                                  onChanged: (address) {
                                                    if (address.length > 41) {
                                                      setState(
                                                        () {
                                                          widget.project.team[
                                                              address] = 1;
                                                          widget.project.team
                                                              .forEach(
                                                            (k, v) {
                                                              if (k !=
                                                                  address) {
                                                                widget.project
                                                                        .team[
                                                                    k] = widget
                                                                            .project
                                                                            .team[
                                                                        k] ??
                                                                    -1 /
                                                                        (widget.project.team.keys.length -
                                                                            1);
                                                              }
                                                            },
                                                          );
                                                        },
                                                      );
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('ADD TEAM MEMBER')),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    width: 180,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black45)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'DISCARD',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(width: 120),
                  // SizedBox(
                  //     height: 40,
                  //     width: 180,
                  //     child: TextButton(
                  //       style: ButtonStyle(
                  //           backgroundColor:
                  //               MaterialStateProperty.all(Colors.red)),
                  //       onPressed: () {
                  //         print("the us33r: $us33r");
                  //         if (widget.project.name!=null&&
                  //             widget.project.description!=null&&
                  //             widget.project.github!=null
                  //         ){
                  //            us33r.createProject(
                  //             widget.project.name!,
                  //              widget.project.description!,
                  //              widget.project.github!);
                  //         }
                  //       },
                  //       child: const Text(
                  //         'ADD PROJECT',
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  TemporaryConsumer(project: widget.project),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      );
    }
  }

  bool pressedName = false;
  bool pressedDesc = false;
  Widget agentName() {
    var whatis = !pressedName
        ? SizedBox(
            width: 450,
            height: 30,
            child: TextButton(
              onPressed: () => setState(() => pressedName = true),
              child: Row(
                children: const [
                  Icon(Icons.edit),
                  Text('Set name', style: TextStyle(fontSize: 21))
                ],
              ),
            ),
          )
        : TextField(
            maxLength: 30,
            style: const TextStyle(fontSize: 21),
            decoration: const InputDecoration(hintText: 'Set project name'),
            onChanged: (value) {
              widget.project.name = value;
            },
          );
    return SizedBox(
      width: 460,
      height: 30,
      child: widget.project.name == null
          ? whatis
          : Text(
              widget.project.name!,
              style: const TextStyle(fontSize: 21),
            ),
    );
  }

  Widget agentDescription() {
    var whatis = !pressedDesc
        ? SizedBox(
            width: 470,
            height: 90,
            child: TextButton(
              onPressed: () => setState(() => pressedDesc = true),
              child: Row(
                children: const [
                  Icon(Icons.edit),
                  Text(
                    'Set description',
                  )
                ],
              ),
            ),
          )
        : TextField(
            maxLength: 141,
            maxLines: 3,
            decoration: const InputDecoration(
                hintText: 'Describe value proposition or utility function.'),
            onChanged: (value) {
              widget.project.description = value;
            },
          );
    return Container(
      width: 470,
      height: 90,
      margin: const EdgeInsets.only(top: 26),
      child: widget.project.description == null
          ? whatis
          : Text(
              widget.project.description!,
              style: const TextStyle(fontSize: 17),
            ),
    );
  }
}

class TemporaryConsumer extends HookWidget {
  const TemporaryConsumer({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final useUser = useProvider(us3r);

    // useUser.state.web3sign();

    return SizedBox(
      height: 40,
      width: 180,
      child: TextButton(
        style:
            ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
        onPressed: () {
          if (project.name != null &&
              project.description != null &&
              project.github != null) {
            // print('user state: ${useUser.state}');
            useUser.state.createProject(
              project.name!,
              project.description!,
              project.github!,
            );
          }
        },
        child: const Text(
          'ADD PROJECT',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
