import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../data/models/user_profile.dart';
import '../../providers/app_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _classController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<AppProvider>(context, listen: false).profile;
    _nameController = TextEditingController(text: profile.name);
    _classController = TextEditingController(text: profile.studentClass);
    _emailController = TextEditingController(text: profile.email);
    _bioController = TextEditingController(text: profile.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NalarAppBar(title: 'Edit Profil Siswa'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Lengkap', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Nama tidak boleh kosong' : null,
                  decoration: const InputDecoration(hintText: 'Nama lengkap siswa'),
                ),
                const SizedBox(height: 14),

                Text('Kelas & Keahlian', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _classController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Kelas tidak boleh kosong' : null,
                  decoration: const InputDecoration(hintText: 'Contoh: X TJKT 1'),
                ),
                const SizedBox(height: 14),

                Text('Email Siswa', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'Email siswa / sekolah'),
                ),
                const SizedBox(height: 14),

                Text('Deskripsi Singkat', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _bioController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Tuliskan sedikit informasi tentang diri kamu atau minat TJKT',
                  ),
                ),
                const SizedBox(height: 24),

                NalarButton(
                  text: 'Simpan Perubahan Profil',
                  icon: Icons.save_rounded,
                  fullWidth: true,
                  onPressed: _saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<AppProvider>(context, listen: false);
    final updated = UserProfile(
      name: _nameController.text.trim(),
      studentClass: _classController.text.trim(),
      email: _emailController.text.trim(),
      bio: _bioController.text.trim(),
      avatar: provider.profile.avatar,
    );

    await provider.updateProfile(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profil berhasil diperbarui!'),
          backgroundColor: NalarColors.success,
        ),
      );
      Navigator.pop(context);
    }
  }
}
