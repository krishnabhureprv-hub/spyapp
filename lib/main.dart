import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spyapp/res/app_colors.dart';
import 'package:spyapp/res/app_theme.dart';
import 'package:spyapp/view/Auth/LoginScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Optimizer App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(colors: LightColors(), isDark: false),
      darkTheme: AppTheme.getTheme(colors: DarkColors(), isDark: true),
      themeMode: ThemeMode.system,
      home: const LoginScreen(),
    );
  }
}
