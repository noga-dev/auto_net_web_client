import 'package:auto_net/screens/assets.dart';
import 'package:auto_net/screens/landing.dart';
import 'package:auto_net/screens/market.dart';
import 'package:auto_net/screens/market/project_details.dart';
import 'package:auto_net/screens/node.dart';
import 'package:auto_net/utils/common.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'main_menu.dart';

const _appBar = MainAppBar();

final beamerDelegate = BeamerDelegate(
  transitionDelegate: const NoAnimationTransitionDelegate(),
  notFoundPage: BeamPage(
    child: Scaffold(
      appBar: _appBar,
      body: page404,
    ),
  ),
  locationBuilder: SimpleLocationBuilder(
    routes: {
      '/': (context, state) => BeamPage(
            key: UniqueKey(),
            title: 'Autonet Home',
            child: const Scaffold(
              appBar: _appBar,
              body: LandingScreen(),
            ),
          ),
      '/market': (context, state) => BeamPage(
            key: UniqueKey(),
            title: 'Autonet Market',
            child: const Scaffold(
              appBar: _appBar,
              body: Market(),
            ),
          ),
      '/assets': (context, state) => BeamPage(
            key: UniqueKey(),
            title: 'Autonet Assets',
            child: const Scaffold(
              appBar: _appBar,
              body: MyAssets(),
            ),
          ),
      '/project/:projectAddress': (context, state) => BeamPage(
            title: 'Autonet Project Details',
            child: Scaffold(
              appBar: _appBar,
              body: ProjectDetailsWrapper(
                projectAddress: state.pathParameters['projectAddress'] ??
                    '0x27a4c07892df16950a5206de35b40a0358de86c0',
              ),
            ),
          ),
      '/node': (context, state) => BeamPage(
            title: 'Autonet New Project',
            child: const Scaffold(
              appBar: _appBar,
              body: Node(),
            ),
          ),
    },
  ),
);
