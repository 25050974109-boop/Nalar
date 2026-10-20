import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/models/borrowing_model.dart';
import '../../providers/app_provider.dart';

class BorrowingHistoryScreen extends StatelessWidget {
  const BorrowingHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final borrowings = provider.borrowings;

    return Scaffold(
      appBar: const NalarAppBar(title: 'Riwayat Peminjaman'),
      body: SafeArea(
        child: borrowings.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_late_rounded, size: 48, color: NalarColors.secondaryText),
                    const SizedBox(height: 12),
                    const Text('Belum ada riwayat peminjaman', style: NalarTextStyles.heading3),
                    const SizedBox(height: 4),
                    const Text('Pengajuan peminjaman alat lab akan tampil di sini.', style: NalarTextStyles.bodySmall),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: borrowings.length,
                itemBuilder: (context, index) {
                  final record = borrowings[index];
                  final statusColor = _getStatusColor(record.status);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: NalarCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(record.itemName, style: NalarTextStyles.heading3),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  record.status.label,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: statusColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('Peminjam: ${record.borrowerName} (${record.borrowerClass})', style: NalarTextStyles.bodySmall),
                          Text('Jumlah: ${record.quantity} Unit', style: NalarTextStyles.bodySmall),
                          Text(
                            'Tanggal: ${_formatDate(record.borrowDate)} s.d. ${_formatDate(record.returnDate)}',
                            style: NalarTextStyles.caption,
                          ),
                          const SizedBox(height: 6),
                          Text('Keperluan: ${record.purpose}', style: NalarTextStyles.bodySmall),
                          if (record.notes != null) Text('Catatan: ${record.notes}', style: NalarTextStyles.caption),
                          
                          if (record.status == BorrowStatus.pending) ...[
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                icon: const Icon(Icons.cancel_outlined, size: 16, color: NalarColors.primaryCoral),
                                label: const Text('Batalkan Pengajuan', style: TextStyle(color: NalarColors.primaryCoral, fontSize: 12)),
                                onPressed: () {
                                  provider.cancelBorrowing(record.id);
                                },
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Color _getStatusColor(BorrowStatus status) {
    switch (status) {
      case BorrowStatus.approved:
      case BorrowStatus.returned:
        return NalarColors.success;
      case BorrowStatus.pending:
        return NalarColors.warning;
      case BorrowStatus.rejected:
      case BorrowStatus.borrowed:
        return NalarColors.primaryCoral;
    }
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
