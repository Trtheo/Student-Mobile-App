import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/session_manager.dart';
import '../theme/theme_provider.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void logout(BuildContext context) async {
    await SessionManager.clearSession();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: FutureBuilder<String?>(
        future: SessionManager.getEmail(),
        builder: (context, snapshot) {
          final email = snapshot.data ?? 'unknown@example.com';
          final name = email.split('@')[0];

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 10),
                Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(email),
                const SizedBox(height: 30),
                SwitchListTile(
                  value: themeProvider.isDark,
                  onChanged: (_) => themeProvider.toggleTheme(),
                  title: const Text("Dark Mode"),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text("Logout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
