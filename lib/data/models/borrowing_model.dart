enum BorrowStatus {
  pending('Menunggu Persetujuan'),
  approved('Disetujui'),
  borrowed('Sedang Dipinjam'),
  returned('Selesai Dikembalikan'),
  rejected('Ditolak');

  final String label;
  const BorrowStatus(this.label);
}

class EquipmentItem {
  final String id;
  final String name;
  final String category;
  final String condition;
  final bool isAvailable;
  final String description;
  final String iconName;

  EquipmentItem({
    required this.id,
    required this.name,
    required this.category,
    required this.condition,
    required this.isAvailable,
    required this.description,
    required this.iconName,
  });
}

class BorrowingRecord {
  final String id;
  final String borrowerName;
  final String borrowerClass;
  final String itemName;
  final int quantity;
  final DateTime borrowDate;
  final DateTime returnDate;
  final String purpose;
  final String? notes;
  final BorrowStatus status;

  BorrowingRecord({
    required this.id,
    required this.borrowerName,
    required this.borrowerClass,
    required this.itemName,
    required this.quantity,
    required this.borrowDate,
    required this.returnDate,
    required this.purpose,
    this.notes,
    this.status = BorrowStatus.pending,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'borrowerName': borrowerName,
        'borrowerClass': borrowerClass,
        'itemName': itemName,
        'quantity': quantity,
        'borrowDate': borrowDate.toIso8601String(),
        'returnDate': returnDate.toIso8601String(),
        'purpose': purpose,
        'notes': notes,
        'status': status.name,
      };

  factory BorrowingRecord.fromJson(Map<String, dynamic> json) => BorrowingRecord(
        id: json['id'] ?? '',
        borrowerName: json['borrowerName'] ?? '',
        borrowerClass: json['borrowerClass'] ?? '',
        itemName: json['itemName'] ?? '',
        quantity: json['quantity'] ?? 1,
        borrowDate: DateTime.tryParse(json['borrowDate'] ?? '') ?? DateTime.now(),
        returnDate: DateTime.tryParse(json['returnDate'] ?? '') ?? DateTime.now(),
        purpose: json['purpose'] ?? '',
        notes: json['notes'],
        status: BorrowStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => BorrowStatus.pending,
        ),
      );
}
