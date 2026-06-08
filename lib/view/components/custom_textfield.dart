import 'package:flutter/material.dart';

class customTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final Widget? suffixIcon;

  const customTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: theme.brightness == Brightness.dark 
                ? const Color(0xFF666666) 
                : theme.textTheme.bodySmall?.color?.withOpacity(0.6),
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: TextStyle(color: theme.textTheme.bodyLarge?.color, fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
