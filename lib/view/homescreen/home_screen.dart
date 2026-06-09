import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../controller/auth_controller.dart';
import '../../repository/auth_repository.dart'; // Jahan `authStateProvider` hai

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🔄 Live user session ko stream se read kar rahe hain
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Tactical Dark Background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "HQ PANEL",
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.redAccent),
            tooltip: "Terminate Session",
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text("NO ACTIVE AGENT"));
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Agent Header Greeting
                Text(
                  "WELCOME back, ${user.displayName ?? 'Agent'}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "OPERATIVE STATUS: ACTIVE",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 30),

                // 🔥 UNIQUE USER ID CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.cyanAccent.withOpacity(0.3), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "UNIQUE OPERATIVE ID (UID)",
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Row containing the actual UID and a Copy Button
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              user.uid, // ✨ Firebase ki unique User ID
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'monospace', // Hacker font vibe
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.copy, color: Colors.grey, size: 20),
                            tooltip: "Copy UID",
                            onPressed: () {
                              // Clipboard me copy karne ka feature
                              Clipboard.setData(ClipboardData(text: user.uid));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("UID COPIED TO CLIPBOARD"),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Extra metadata for tactical feel
                Text(
                  "SECURE IDENTITY EMAIL: ${user.email}",
                  style: const TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'monospace'),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
        error: (e, _) => Center(child: Text("ERROR: $e")),
      ),
    );
  }
}