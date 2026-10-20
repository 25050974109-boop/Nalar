import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';
import '../../providers/app_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final profile = provider.profile;

    return Scaffold(
      appBar: NalarAppBar(
        title: 'Profil Saya',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_rounded, color: NalarColors.charcoal),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Avatar & Name Card
              NalarCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: NalarColors.primaryCoral,
                      child: Text(
                        profile.name.isNotEmpty ? profile.name[0].toUpperCase() : 'S',
                        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: NalarColors.white),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(profile.name, style: NalarTextStyles.heading1),
                    const SizedBox(height: 4),
                    Chip(
                      label: Text(profile.studentClass),
                      backgroundColor: NalarColors.softCoral,
                      labelStyle: const TextStyle(color: NalarColors.primaryCoral, fontWeight: FontWeight.bold),
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Profile Info Fields
              NalarCard(
                child: Column(
                  children: [
                    _buildTile(Icons.email_outlined, 'Email', profile.email),
                    const Divider(height: 1, color: NalarColors.border),
                    _buildTile(Icons.school_outlined, 'Kelas', profile.studentClass),
                    const Divider(height: 1, color: NalarColors.border),
                    _buildTile(Icons.info_outline_rounded, 'Deskripsi Profil', profile.bio),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              NalarButton(
                text: 'Edit Profil',
                icon: Icons.edit_rounded,
                fullWidth: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: NalarColors.primaryCoral),
      title: Text(title, style: NalarTextStyles.caption),
      subtitle: Text(value, style: NalarTextStyles.heading3.copyWith(fontSize: 14)),
    );
  }
}
