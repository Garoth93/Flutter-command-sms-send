import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test4/app/di/injector.dart';
import 'presentation/command/command_page.dart';
import 'presentation/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: LoginPage.route,
  routes: [
    GoRoute(
      path: LoginPage.route,
      name: LoginPage.route,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: CommandPage.route,
      name: CommandPage.route,
      builder: (context, state) => const CommandPage(),
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Command sms sender",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
        fontFamily: 'roboto',
      ),
      routerConfig: _router,
    );
  }
}
