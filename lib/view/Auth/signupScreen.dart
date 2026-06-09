import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spyapp/controller/auth_controller.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isAgreed = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final authLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.shield_outlined, color: theme.colorScheme.primary, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      "S.P.E.C.T.R.E.",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "SYSTEM STATUS: AWAITING INPUT",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "RECRUITMENT",
                  style: TextStyle(
                    color: isDark ? Colors.white : const Color(0xFF101828),
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Create your digital identity for secure operations. High-level encryption and biometric markers will be applied to your profile.",
                  style: TextStyle(
                    color: isDark ? const Color(0xFF666666) : const Color(0xFF757575),
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),
                customTextField(
                  label: "Full Name",
                  hintText: "Eg. Krishna Bhure",
                  controller: _nameController,
                ),
                customTextField(
                  label: "Email Id",
                  hintText: "Eg. krishna@gmail.com",
                  controller: _emailController,
                ),
                customTextField(
                  label: "create password",
                  hintText: "••••••••••••",
                  controller: _passwordController,
                  isPassword: true,
                  suffixIcon: Icon(
                    Icons.visibility_outlined,
                    color: isDark ? const Color(0xFF666666) : const Color(0xFF757575),
                    size: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SECURITY STRENGTH",
                      style: TextStyle(
                        color: isDark ? const Color(0xFF666666) : const Color(0xFF757575),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "ANALYZING...",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: Container(height: 4, color: theme.colorScheme.primary)),
                    const SizedBox(width: 4),
                    Expanded(child: Container(height: 4, color: theme.colorScheme.primary.withOpacity(0.5))),
                    const SizedBox(width: 4),
                    Expanded(child: Container(height: 4, color: isDark ? const Color(0xFF222222) : Colors.black12)),
                    const SizedBox(width: 4),
                    Expanded(child: Container(height: 4, color: isDark ? const Color(0xFF222222) : Colors.black12)),
                  ],
                ),
                const SizedBox(height: 24),
            
                customTextField(
                  label: "Confirm password",
                  hintText: "RE-ENTER PASSWORD",
                  controller: _confirmPasswordController,
                  isPassword: true,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: _isAgreed,
                        activeColor: theme.colorScheme.primary,
                        checkColor: isDark ? Colors.black : Colors.white,
                        side: BorderSide(
                          color: isDark ? const Color(0xFF333333) : Colors.black26,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                        onChanged: (val) {
                          setState(() {
                            _isAgreed = val ?? false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(
                            color: isDark ? const Color(0xFF666666) : const Color(0xFF757575),
                            fontSize: 12,
                            height: 1.3,
                          ),
                          children: [
                            TextSpan(
                              text: "classified terms",
                              style: TextStyle(
                                color: theme.colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: " and unconditional operational compliance."),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
            
                CustomButton(
                  text: "Establish Identity",
                  isLoading: authLoading,
                  icon: Icon(
                    Icons.fingerprint,
                    color: isDark ? const Color(0xFF0A0A0A) : Colors.white,
                    size: 18,
                  ),
                  onTap: () {
                    if (_nameController.text.trim().isEmpty || 
                        _emailController.text.trim().isEmpty || 
                        _passwordController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("CRITICAL: All fields are mandatory.")),
                      );
                      return;
                    }

                    if (_passwordController.text != _confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("CIPHER MISMATCH: Passwords do not match.")),
                      );
                      return;
                    }

                    if (!_isAgreed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("ERROR: Tactical compliance agreement required.")),
                      );
                      return;
                    }

                    // 🚀 Sab sahi hai! Ab controller ko signal bhejo account create karne ke liye
                    ref.read(authControllerProvider.notifier).signUp(
                          name: _nameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          context: context,
                    );
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Already processed?   ",
                        style: TextStyle(
                          color: isDark ? const Color(0xFF666666) : const Color(0xFF757575),
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "LOGIN",
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}