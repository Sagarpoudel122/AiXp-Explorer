import 'package:e2_explorer/src/features/manager/presentation/config_startup_page.dart';
import 'package:e2_explorer/src/features/payload_viewer/presentation/payload_viewer.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/dashboard_page.dart';
import 'package:e2_explorer/src/features/unfeatured_yet/network_monitor/presentation/network_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/unfeatured_yet/connection/presentation/connection_page.dart';

part 'route_names.dart';

final GlobalKey<NavigatorState> homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');

class AppRoutes {
  const AppRoutes._();

  static final GoRouter routes = GoRouter(
    initialLocation: RouteLocations.connection,
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        /// This route acts as the index
        path: RouteLocations.connection,
        name: RouteNames.connection,
        builder: (BuildContext context, GoRouterState state) {
          return const ConnectionPage();
        },
      ),
      ShellRoute(
        navigatorKey: homeNavigatorKey,
        builder: (context, state, child) => DashboardPage(child: child),
        routes: [
          GoRoute(
            path: RouteLocations.network,
            name: RouteNames.network,
            builder: (context, state) => const NetworkPage(),
          ),
          GoRoute(
            path: RouteLocations.config,
            name: RouteNames.config,
            builder: (context, state) => const ConfigStartupPage(),
          ),
          GoRoute(
            path: RouteLocations.payloadViewer,
            name: RouteNames.payloadViewer,
            builder: (context, state) {
              return const PayloadViewer(boxName: '');
            },
          ),
        ],
      ),
    ],
  );
}
