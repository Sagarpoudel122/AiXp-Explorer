import 'dart:async';

import 'package:e2_explorer/src/features/command_launcher/presentation/command_launcher_page.dart';
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
            path: RouteLocations.commandLauncher,
            name: RouteNames.commandLauncher,
            builder: (context, state) => const CommandLauncherPage(),
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

  /// every navigation or refresh will go through here to validate
  /// user authentication state.
  ///
  /// Unlike checking the user auth from SharedPreferences or other storage.
  /// This authentication will connect directly to the [AuthenticationBloc]
  /// or go to `/` route to check the user auth.
  static FutureOr<String?> _navigationGuard(
    BuildContext context,
    GoRouterState state,
  ) {
    // final String path = state.subloc;
    // final AuthenticationState authState = context.read<AuthenticationBloc>().state;
    //
    // final bool isAuthenticationScreen =
    //     path == LoginScreen.fullPath || path == ResetPasswordScreen.fullPath || path == ForgotPasswordScreen.fullPath;
    //
    // // Do not apply guard to loading screen.
    // if (path == InitialScreen.fullPath) {
    //   return null;
    // }
    //
    // // Redirect to the initial screen if authentication bloc is not initialized.
    // if (!authState.isInitialized) {
    //   return InitialScreen.buildFullPath(state.location);
    // }
    //
    // // Ensure unauthenticated users are redirected to login screen.
    // if (!authState.isAuthenticated && !isAuthenticationScreen) {
    //   return LoginScreen.buildFullPath(state.location);
    // }
    //
    // // Ensure authenticated users are redirected to the default app screen.
    // if (authState.isAuthenticated && isAuthenticationScreen) {
    //   return EquipmentsListScreen.fullPath;
    // }
    //
    // if (ConfigRepository.isBanksight) {
    //   if (disabledRoutesOnBanksight.contains(state.subloc)) {
    //     return '/';
    //   }
    // }
    return null;
  }
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
