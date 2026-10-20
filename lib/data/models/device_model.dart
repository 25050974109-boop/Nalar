enum DeviceCategory {
  computer('Komputer'),
  network('Perangkat Jaringan'),
  cable('Kabel & Konektor'),
  telecom('Perangkat Telekomunikasi');

  final String label;
  const DeviceCategory(this.label);
}

class DeviceItem {
  final String id;
  final String name;
  final DeviceCategory category;
  final String description;
  final String functionText;
  final String exampleUsage;
  final String iconName;

  DeviceItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.functionText,
    required this.exampleUsage,
    required this.iconName,
  });
}
