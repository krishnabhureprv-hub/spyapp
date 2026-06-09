import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repository/auth_repository.dart';

// UI me is controller ko listen karne ke liye provider
// Yeh StateNotifierProvider ek boolean hold karega (true = loading, false = idle)
final authControllerProvider = StateNotifierProvider<AuthController, bool>((ref) {
  final authRepository = ref.watch(AuthRepositoryProvider);
  return AuthController(authRepository);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  // Shuruat me loading state false rahegi
  AuthController(this._authRepository) : super(false);

  // 1. SIGN UP IMPLEMENTATION
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // Loading Shuru 🔄

    try {
      await _authRepository.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );
      state = false; // Loading Khatam

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OPERATIVE IDENTITY ESTABLISHED SUCCESSFULLY!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context); // Account bante hi Login screen par wapas bhej do
      }
    } catch (e) {
      state = false; // Error aane par loader band
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("ENCRYPTION FAILED: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  // 2. SIGN IN / LOGIN IMPLEMENTATION
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true; // Loading Shuru 🔄

    try {
      await _authRepository.signInWithEmail(email: email, password: password);
      state = false; // Loading Khatam

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("ACCESS GRANTED: SYSTEM DECRYPTED!"),
            backgroundColor: Colors.green,
          ),
        );
        
        // TODO: Yahan se user ko Dashboard/Home Screen par push karenge
        // Navigator.pushReplacementNamed(context, '/dashboard');
      }
    } catch (e) {
      state = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("ACCESS DENIED: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  // 3. PASSWORD RESET IMPLEMENTATION
  Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    state = true;
    try {
      await _authRepository.sendPasswordReset(email: email);
      state = false;

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("CIPHER RECOVERY LINK DISPATCHED TO YOUR EMAIL!"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      state = false;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("RECOVERY FAILED: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  // 4. LOGOUT IMPLEMENTATION
  Future<void> logout() async {
    await _authRepository.signOut();
  }
}