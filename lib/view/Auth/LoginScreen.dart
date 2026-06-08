import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spyapp/view/Auth/signupScreen.dart';
import 'package:spyapp/view/components/custom_Button.dart';
import 'package:spyapp/view/components/custom_textfield.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _identityController = TextEditingController();
  final _cipherController = TextEditingController();

  @override
  void dispose() {
    _identityController.dispose();
    _cipherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.security,
                    color: theme.colorScheme.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "S.P.E.C.T.R.E",
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                "ACCESS\nGRANTED\nONLY",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Enter your Credential to decrypt your session.",
                style: TextStyle(
                  color: theme.brightness == Brightness.dark 
                      ? const Color(0xFF666666) 
                      : const Color(0xFF757575),
                  fontSize: 13),
              ),
              const SizedBox(height: 40),
              customTextField(
                label: "Email",
                hintText: "Enter ur Email",
                controller: _identityController,
              ),
              customTextField(
                label: "Password",
                hintText: "••••••••••••",
                controller: _cipherController,
                isPassword: true,
                suffixIcon: const Icon(Icons.visibility_off_outlined),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "FORGOT PASSWORD",
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark 
                        ? const Color(0xFF666666) 
                        : const Color(0xFF757575),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomButton(
                text: "Inatilize Session",
                icon: Icon(
                  Icons.flash_on,
                  color: theme.brightness == Brightness.dark ? const Color(0xFF0A0A0A) : Colors.black,
                  size: 16,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "New Operative?   ",
                      style: TextStyle(
                        color: theme.brightness == Brightness.dark 
                            ? const Color(0xFF666666) 
                            : const Color(0xFF757575),
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: "ESTABLISH IDENTITY",
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
    );
  }
}
