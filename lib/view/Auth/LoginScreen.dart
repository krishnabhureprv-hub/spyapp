import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spyapp/res/app_colors.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.security,
                    color: AppColors.primaryNeon,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "S.P.E.C.T.R.E",
                    style: TextStyle(
                      color: AppColors.primaryNeon,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "ACCESS\nGRANTED\nONLY",
                style: TextStyle(
                  color: AppColors.textMain,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Enter your Credential to decrypt your session.",
                style: TextStyle(color: AppColors.textMuted, fontSize: 13),
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
                  child: const Text(
                    "FORGOT PASSWORD",
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Inatilize Session",
                icon: const Icon(
                  Icons.flash_on,
                  color: AppColors.background,
                  size: 16,
                ),
                onTap: () {},
              ),
              const SizedBox(height: 40),
              Center(
                child: GestureDetector(
                  onTap: () {},
                  child: RichText(
                    text: const TextSpan(
                      text: "New Operative?   ",
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                      ),
                      children: [
                        TextSpan(
                          text: "ESTABLISH IDENTITY",
                          style: TextStyle(
                            color: AppColors.primaryNeon,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
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
