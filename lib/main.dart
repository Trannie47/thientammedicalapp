import 'package:flutter/material.dart';
import 'package:thientammedicalapp/pages/main/page.dart';
import 'pages/splash/page.dart';
import 'pages/login/page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THIÊN TÂM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}

