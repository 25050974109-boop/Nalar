import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../data/models/borrowing_model.dart';
import '../../providers/app_provider.dart';

class BorrowingFormScreen extends StatefulWidget {
  final EquipmentItem equipment;

  const BorrowingFormScreen({super.key, required this.equipment});

  @override
  State<BorrowingFormScreen> createState() => _BorrowingFormScreenState();
}

class _BorrowingFormScreenState extends State<BorrowingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _classController;
  late TextEditingController _purposeController;
  late TextEditingController _notesController;

  int _quantity = 1;
  DateTime _borrowDate = DateTime.now();
  DateTime _returnDate = DateTime.now().add(const Duration(days: 2));

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppProvider>(context, listen: false);
    _nameController = TextEditingController(text: provider.profile.name);
    _classController = TextEditingController(text: provider.profile.studentClass);
    _purposeController = TextEditingController(text: 'Praktikum Mandiri Lab TJKT');
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _classController.dispose();
    _purposeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NalarAppBar(title: 'Formulir Peminjaman'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Equipment Summary
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: NalarColors.softCoral,
                    borderRadius: NalarRadius.borderMd,
                    border: Border.all(color: NalarColors.brightCoral.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.inventory_2_rounded, color: NalarColors.primaryCoral),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.equipment.name, style: NalarTextStyles.heading3),
                            Text('Kondisi: ${widget.equipment.condition}', style: NalarTextStyles.caption),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Name & Class
                Text('Nama Peminjam', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _nameController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Nama wajib diisi' : null,
                  decoration: const InputDecoration(hintText: 'Nama lengkap siswa'),
                ),
                const SizedBox(height: 12),

                Text('Kelas', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _classController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Kelas wajib diisi' : null,
                  decoration: const InputDecoration(hintText: 'Contoh: X TJKT 1'),
                ),
                const SizedBox(height: 12),

                // Quantity
                Text('Jumlah Alat', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline_rounded, color: NalarColors.primaryCoral),
                      onPressed: () {
                        if (_quantity > 1) setState(() => _quantity--);
                      },
                    ),
                    Text('$_quantity', style: NalarTextStyles.heading2),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline_rounded, color: NalarColors.primaryCoral),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Borrow Date
                Text('Tanggal Peminjaman', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _borrowDate,
                      firstDate: DateTime.now().subtract(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (picked != null) {
                      setState(() {
                        _borrowDate = picked;
                        if (_returnDate.isBefore(_borrowDate)) {
                          _returnDate = _borrowDate.add(const Duration(days: 1));
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: NalarColors.white,
                      borderRadius: NalarRadius.borderMd,
                      border: Border.all(color: NalarColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_borrowDate.day}/${_borrowDate.month}/${_borrowDate.year}'),
                        const Icon(Icons.calendar_today_rounded, size: 18, color: NalarColors.secondaryText),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Planned Return Date
                Text('Rencana Tanggal Pengembalian', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _returnDate,
                      firstDate: _borrowDate,
                      lastDate: DateTime.now().add(const Duration(days: 60)),
                    );
                    if (picked != null) {
                      setState(() => _returnDate = picked);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: NalarColors.white,
                      borderRadius: NalarRadius.borderMd,
                      border: Border.all(color: NalarColors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${_returnDate.day}/${_returnDate.month}/${_returnDate.year}'),
                        const Icon(Icons.calendar_today_rounded, size: 18, color: NalarColors.secondaryText),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Purpose
                Text('Keperluan Peminjaman', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _purposeController,
                  validator: (val) => val == null || val.trim().isEmpty ? 'Keperluan wajib diisi' : null,
                  decoration: const InputDecoration(hintText: 'Misal: Praktikum Pengkabelan LAN'),
                ),
                const SizedBox(height: 12),

                // Additional Notes
                Text('Catatan Tambahan (Opsional)', style: NalarTextStyles.heading3),
                const SizedBox(height: 6),
                TextFormField(
                  controller: _notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(hintText: 'Keterangan tambahan jika ada'),
                ),
                const SizedBox(height: 24),

                // Submit Button
                NalarButton(
                  text: 'Kirim Pengajuan Peminjaman',
                  icon: Icons.send_rounded,
                  fullWidth: true,
                  onPressed: _submitForm,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_returnDate.isBefore(_borrowDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tanggal pengembalian tidak boleh lebih awal dari tanggal peminjaman.'),
          backgroundColor: NalarColors.primaryCoral,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Pengajuan'),
        content: Text(
          'Simpan pengajuan peminjaman ${_quantity}x ${widget.equipment.name} untuk tanggal ${_borrowDate.day}/${_borrowDate.month}/${_borrowDate.year}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);

              final newRecord = BorrowingRecord(
                id: 'borr_${DateTime.now().millisecondsSinceEpoch}',
                borrowerName: _nameController.text.trim(),
                borrowerClass: _classController.text.trim(),
                itemName: widget.equipment.name,
                quantity: _quantity,
                borrowDate: _borrowDate,
                returnDate: _returnDate,
                purpose: _purposeController.text.trim(),
                notes: _notesController.text.trim().isNotEmpty ? _notesController.text.trim() : null,
                status: BorrowStatus.pending,
              );

              final provider = Provider.of<AppProvider>(context, listen: false);
              provider.addBorrowing(newRecord);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pengajuan peminjaman berhasil disimpan!'),
                  backgroundColor: NalarColors.success,
                ),
              );

              Navigator.pop(context);
            },
            child: const Text('Ya, Simpan'),
          ),
        ],
      ),
    );
  }
}
