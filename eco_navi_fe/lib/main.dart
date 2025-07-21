import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: MainRouter.router);
  }
}

class MainRouter {
  static GoRouter router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: "/home",
        name: "home",
        builder:
            (BuildContext context, GoRouterState state) => const HomePage(),
      ),
    ],
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          //GoRouter.of(context).goNamed("page1");
        },
        child: Text('test'),
      ),
    );
  }
}
