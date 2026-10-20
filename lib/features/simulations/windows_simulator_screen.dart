import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';

class WindowsSimulatorScreen extends StatefulWidget {
  const WindowsSimulatorScreen({super.key});

  @override
  State<WindowsSimulatorScreen> createState() => _WindowsSimulatorScreenState();
}

class _WindowsSimulatorScreenState extends State<WindowsSimulatorScreen> {
  static const String _win7SimuUrl = 'https://win7simu.visnalize.com/';

  @override
  void initState() {
    super.initState();
    // Auto launch Web Win7Simu when opening screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchWin7Simu();
    });
  }

  Future<void> _launchWin7Simu() async {
    final Uri url = Uri.parse(_win7SimuUrl);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await launchUrl(url, mode: LaunchMode.platformDefault);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Membuka https://win7simu.visnalize.com/ di browser...'),
            backgroundColor: NalarColors.primaryCoral,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NalarAppBar(
        title: 'Windows OS Simulator',
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_browser_rounded, color: NalarColors.primaryCoral),
            tooltip: 'Buka Web Win7Simu',
            onPressed: _launchWin7Simu,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Hero Banner Card
              NalarCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: NalarColors.softCoral,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.desktop_windows_rounded,
                        size: 64,
                        color: NalarColors.primaryCoral,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Win7Simu (Windows Simulator)',
                      style: NalarTextStyles.heading1,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Simulasi interaktif Sistem Operasi Windows melalui platform web win7simu.visnalize.com.',
                      style: NalarTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    NalarButton(
                      text: 'Membuka Web Simulator (win7simu.visnalize.com)',
                      icon: Icons.open_in_new_rounded,
                      fullWidth: true,
                      onPressed: _launchWin7Simu,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Feature Info
              NalarCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fitur Simulator Web Win7Simu:', style: NalarTextStyles.heading3),
                    const SizedBox(height: 10),
                    _buildFeatureRow(Icons.window_rounded, 'Antarmuka Windows interaktif lengkap'),
                    _buildFeatureRow(Icons.folder_open_rounded, 'File Explorer & Manajemen Berkas'),
                    _buildFeatureRow(Icons.terminal_rounded, 'Command Prompt (CMD) & Game bawaan'),
                    _buildFeatureRow(Icons.language_rounded, 'Akses langsung via https://win7simu.visnalize.com/'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: NalarColors.primaryCoral),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: NalarTextStyles.bodySmall)),
        ],
      ),
    );
  }
}
