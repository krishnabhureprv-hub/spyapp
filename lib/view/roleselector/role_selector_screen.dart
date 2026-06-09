import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spyapp/view/homescreen/child_dashboard.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  bool _isLoading = false;

  Future<void> _setDeviceRole(String role) async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw "No authenticated session found.";

      // 1. SharedPreferences mein locally save karo
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('device_role', role);

      // 2. Firestore database update
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'role': role,
        'updated_at': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      // 3. Respective Dashboard par routing
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => role == 'parent'
                ? const ChildDashboard()
                : const ChildDashboard(),
          ),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("CONFIGURATION ERROR: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1515), // Deep Cyber Dark Background
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF9EFF00)),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top Header Branding
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
                          Icons.settings_outlined,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),

                    const Spacer(flex: 1),

                    // Title Area
                    Text(
                      "OPERATIONAL PROTOCOL",
                      style: TextStyle(
                        color: const Color(0xFF9EFF00),
                        fontFamily: 'monospace',
                        fontSize: 12,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "SELECT\nOPERATIONAL\nROLE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        height: 1.1,
                      ),
                    ),

                    const Spacer(flex: 1),

                    // Main Role Assignment Frame
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111E1E),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white10, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container Sub-header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.badge_outlined,
                                    color: Color(0xFF9EFF00),
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "ROLE ASSIGNMENT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "V.4.2.0-STABLE",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // 🟢 PARENT APP SELECTION CARD (Active Color Scheme)
                          InkWell(
                            onTap: () => _setDeviceRole('parent'),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: const Color(
                                  0xFF9EFF00,
                                ), // Solid Tactical Lime
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.shield,
                                      color: Color(0xFF0D1515),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "PARENT APP",
                                    style: TextStyle(
                                      color: Color(0xFF0D1515),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "CONTROL & SURVEILLANCE",
                                    style: TextStyle(
                                      color: const Color(
                                        0xFF0D1515,
                                      ).withOpacity(0.6),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // 📡 CHILD APP SELECTION CARD (Outline Style)
                          InkWell(
                            onTap: () => _setDeviceRole('child'),
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(
                                    0xFF9EFF00,
                                  ).withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFF9EFF00,
                                      ).withOpacity(0.05),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.sensors,
                                      color: Color(0xFF9EFF00),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "CHILD APP",
                                    style: TextStyle(
                                      color: Color(0xFF9EFF00),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ).runtimeType ==
                                          TextStyle
                                      ? Text(
                                          "SIGNAL TRANSMITTER",
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 1),

                    // Bottom Warning Text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Warning: Selection is permanent for this device session. All data is routed through encrypted tunnels.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 11,
                          height: 1.3,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
      ),
    );
  }
}
