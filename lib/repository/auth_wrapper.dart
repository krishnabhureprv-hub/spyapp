import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spyapp/view/Auth/LoginScreen.dart';
import 'package:spyapp/view/homescreen/home_screen.dart';
import '../../repository/auth_repository.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔄 Firebase Auth Stream ko watch kar rahe hain
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const HomeScreen(); // 🔥 User mil gaya -> Go to Home Page
        }
        return const LoginScreen(); // 🔒 User nahi mila -> Go to Login
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent),
        ),
      ),
      error: (e, trace) => Scaffold(
        body: Center(child: Text("CRITICAL EXCEPTION: $e")),
      ),
    );
  }
}