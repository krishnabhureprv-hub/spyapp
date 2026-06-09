import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../controller/auth_controller.dart'; // Apne controller ka path dena
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChildDashboard extends ConsumerWidget {
  const ChildDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔑 Firebase se current user ki Unique ID (UID) li
    final user = FirebaseAuth.instance.currentUser;
    final String currentUID = user?.uid ?? "NO_ACTIVE_TOKEN_FOUND";

    // UI ke display ke liye UID ka ek chota token version (Jaise tumhare image me hai)
    final String displayToken = currentUID.length > 8
        ? "SPECTRE_${currentUID.substring(0, 6).toUpperCase()}"
        : "SPECTRE_X_42";

    return Scaffold(
      backgroundColor: const Color(0xFF0D1515), // Same Cyber Dark Background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Top Header Branding Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.shield_outlined,
                        color: Color(0xFF9EFF00),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "S.P.E.C.T.R.E.",
                        style: TextStyle(
                          color: const Color(0xFF9EFF00),
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.sensors,
                    color: Color(0xFF9EFF00),
                    size: 18,
                  ), // Transmitter pulse icon
                ],
              ),

              const SizedBox(height: 25),

              // 2. Sub-title
              Text(
                "AUTHENTICATED CLIENT ROLE: CHILD_APP",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontFamily: 'monospace',
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // 3. Main Dynamic Token Text
              Text(
                "IDENTITY TOKEN:\n$displayToken",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Neon underline divider
              Container(
                width: 45,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF9EFF00),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              const Spacer(),

              // 🖼️ 4. THE TACTICAL QR CONTAINER (Matches image layout)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF111E1E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10, width: 1),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors
                        .white, // QR code visibility ke liye white background container
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    // 🔥 Yeh real-time me user ki ID ko QR me badal raha hai
                    child: QrImageView(
                      data:
                          currentUID, // Parent device isi string ko scan karke save karega
                      version: QrVersions.auto,
                      size: 220.0,
                      gapless: true,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Color(0xFF0D1515), // Dark elements inside QR
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color(0xFF0D1515),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // 5. STATUS INDICATOR BOX
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF111E1E),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF9EFF00).withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.verified_user_outlined,
                      color: Color(0xFF9EFF00),
                      size: 20,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "SUCCESSFULLY PAIRED BY PARENT DEVICE",
                      style: TextStyle(
                        color: const Color(0xFF9EFF00).withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // 6. BACK TO HUB BUTTON
              InkWell(
                onTap: () {
                  // Session terminate/logout ya back navigation ka control
                  ref.read(authControllerProvider.notifier).logout();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white10, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF9EFF00),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "BACK TO HUB",
                        style: TextStyle(
                          color: const Color(0xFF9EFF00),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
