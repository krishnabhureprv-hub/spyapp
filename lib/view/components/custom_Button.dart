import 'package:flutter/material.dart';
import '../../res/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme  = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: theme.colorScheme.primary.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4,
            ), // Semi-sharp corners like UI
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: theme.brightness == Brightness.dark ? Colors.black : Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text.toUpperCase(),
                    style: TextStyle(
                      color: theme.brightness == Brightness.dark ? const Color(0xFF0A0A0A) : Colors.black,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      fontSize: 14,
                    ),
                  ),
                  if (icon != null) ...[const SizedBox(width: 8), icon!],
                ],
              ),
      ),
    );
  }
}
