import 'dart:ui';

import 'package:eco_navi_fe/pages/home_page.dart';
import 'package:eco_navi_fe/pages/map_page.dart';
import 'package:eco_navi_fe/pages/profile_page.dart';
import 'package:eco_navi_fe/pages/store_page.dart';
import 'package:eco_navi_fe/pages/suggestion_page.dart';
import 'package:eco_navi_fe/screens/navi_screen.dart';
import 'package:eco_navi_fe/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  final GlobalKey<NavigatorState> _rootNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _shellNavKey = GlobalKey<NavigatorState>();

  GoRouter router() => GoRouter(
    initialLocation: "/",
    navigatorKey: _rootNavKey,
    routes: [
      GoRoute(
        path: "/",
        name: "Splash",
        builder: (context, state) => const SplashScreen(),
      ),
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavKey,
        builder:
            (context, state, navigationShell) =>
                NaviScreen(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/suggestion',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: SuggestionPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/map',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: MapPage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: HomePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/store',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: StorePage()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: ProfilePage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp.router(
      routerConfig: router(),
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFD9D9D9),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        fontFamily: 'Inter',
      ),
      builder: (context, child) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double height = size.height, width = size.width;
              if (kIsWeb) {
                height = size.height - 20;
                width = height * (402 / 874);
              }
              return Center(
                child: SizedBox(height: height, width: width, child: child!),
              );
            },
          ),
        );
      },
    );
  }
}
