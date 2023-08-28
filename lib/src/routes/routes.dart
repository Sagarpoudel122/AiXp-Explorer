import 'package:e2_explorer/src/features/unfeatured_yet/dashboard/presentation/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/unfeatured_yet/connection/presentation/connection_page.dart';

part 'route_names.dart';

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
          return ConnectionPage();
        },
      ),
      GoRoute(
        path: RouteLocations.dashboard,
        name: RouteNames.dashboard,
        builder: (BuildContext context, GoRouterState state) {
          return DashboardPage();
        },
      ),
    ],
  );
}
