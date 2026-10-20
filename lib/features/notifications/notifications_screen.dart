import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_card.dart';
import '../../data/models/notification_model.dart';
import '../../providers/app_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationCategory _selectedCategory = NotificationCategory.all;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final allNotifs = provider.notifications;

    final filteredNotifs = allNotifs.where((n) {
      if (_selectedCategory == NotificationCategory.all) return true;
      return n.category == _selectedCategory;
    }).toList();

    return Scaffold(
      appBar: const NalarAppBar(title: 'Notifikasi'),
      body: SafeArea(
        child: Column(
          children: [
            // Category Filter Tabs
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                children: NotificationCategory.values.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(cat.label),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedCategory = cat);
                        }
                      },
                      selectedColor: NalarColors.primaryCoral,
                      backgroundColor: NalarColors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? NalarColors.white : NalarColors.charcoal,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: NalarRadius.borderMd,
                        side: BorderSide(
                          color: isSelected ? NalarColors.primaryCoral : NalarColors.border,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),

            // Notifications List
            Expanded(
              child: filteredNotifs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_off_rounded, size: 48, color: NalarColors.secondaryText),
                          const SizedBox(height: 12),
                          const Text('Tidak ada notifikasi', style: NalarTextStyles.heading3),
                          const SizedBox(height: 4),
                          const Text('Notifikasi aktivitas belajar akan muncul di sini.', style: NalarTextStyles.bodySmall),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      itemCount: filteredNotifs.length,
                      itemBuilder: (context, index) {
                        final notif = filteredNotifs[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: NalarCard(
                            onTap: () {
                              provider.markNotificationRead(notif.id);
                            },
                            backgroundColor: notif.isRead ? NalarColors.white : NalarColors.softCoral.withOpacity(0.4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: _getCategoryColor(notif.category).withOpacity(0.12),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getCategoryIcon(notif.category),
                                    color: _getCategoryColor(notif.category),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              notif.title,
                                              style: NalarTextStyles.heading3.copyWith(
                                                fontWeight: notif.isRead ? FontWeight.w600 : FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (!notif.isRead)
                                            Container(
                                              width: 8,
                                              height: 8,
                                              decoration: const BoxDecoration(
                                                color: NalarColors.primaryCoral,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(notif.body, style: NalarTextStyles.bodySmall),
                                      const SizedBox(height: 6),
                                      Text(
                                        _formatTime(notif.timestamp),
                                        style: NalarTextStyles.caption.copyWith(fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.learning:
        return Icons.school_rounded;
      case NotificationCategory.borrowing:
        return Icons.inventory_2_rounded;
      case NotificationCategory.project:
        return Icons.assignment_rounded;
      case NotificationCategory.attendance:
        return Icons.fact_check_rounded;
      default:
        return Icons.notifications_rounded;
    }
  }

  Color _getCategoryColor(NotificationCategory cat) {
    switch (cat) {
      case NotificationCategory.learning:
        return NalarColors.primaryCoral;
      case NotificationCategory.borrowing:
        return NalarColors.warning;
      case NotificationCategory.project:
        return NalarColors.primaryCoral;
      case NotificationCategory.attendance:
        return NalarColors.success;
      default:
        return NalarColors.primaryCoral;
    }
  }

  String _formatTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} menit yang lalu';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} jam yang lalu';
    } else {
      return '${diff.inDays} hari yang lalu';
    }
  }
}
