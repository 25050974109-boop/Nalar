import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';

class PtDevice {
  final String id;
  String name;
  String type; // 'pc', 'laptop', 'router', 'switch', 'server'
  String ipAddress;
  String subnetMask;
  bool isPortOn;
  Offset position;

  PtDevice({
    required this.id,
    required this.name,
    required this.type,
    required this.ipAddress,
    required this.subnetMask,
    this.isPortOn = true,
    required this.position,
  });
}

class PtConnection {
  final String id;
  final String fromDeviceId;
  final String toDeviceId;
  final String cableType; // 'straight', 'cross', 'fiber'

  PtConnection({
    required this.id,
    required this.fromDeviceId,
    required this.toDeviceId,
    required this.cableType,
  });
}

class NetworkSimulatorScreen extends StatefulWidget {
  const NetworkSimulatorScreen({super.key});

  @override
  State<NetworkSimulatorScreen> createState() => _NetworkSimulatorScreenState();
}

class _NetworkSimulatorScreenState extends State<NetworkSimulatorScreen> {
  final List<PtDevice> _devices = [
    PtDevice(
      id: 'pc1',
      name: 'PC-0',
      type: 'pc',
      ipAddress: '192.168.1.10',
      subnetMask: '255.255.255.0',
      position: const Offset(40, 50),
    ),
    PtDevice(
      id: 'sw1',
      name: 'Switch-2960',
      type: 'switch',
      ipAddress: '192.168.1.1',
      subnetMask: '255.255.255.0',
      position: const Offset(150, 150),
    ),
    PtDevice(
      id: 'r1',
      name: 'Router-2911',
      type: 'router',
      ipAddress: '192.168.1.254',
      subnetMask: '255.255.255.0',
      position: const Offset(150, 260),
    ),
    PtDevice(
      id: 'srv1',
      name: 'Server-Web',
      type: 'server',
      ipAddress: '192.168.1.100',
      subnetMask: '255.255.255.0',
      position: const Offset(260, 50),
    ),
  ];

  final List<PtConnection> _connections = [
    PtConnection(id: 'c1', fromDeviceId: 'pc1', toDeviceId: 'sw1', cableType: 'straight'),
    PtConnection(id: 'c2', fromDeviceId: 'sw1', toDeviceId: 'r1', cableType: 'straight'),
    PtConnection(id: 'c3', fromDeviceId: 'sw1', toDeviceId: 'srv1', cableType: 'straight'),
  ];

  final List<String> _pduLogs = [
    '[Packet Tracer] Mode Simulasi Aktif.',
    '[Link Status] Port FastEthernet0/1 UP (Green LED).',
  ];

  String? _connectModeSourceId;
  String? _pduSourceId = 'pc1';
  String? _pduTargetId = 'srv1';
  bool _isSimulatingPdu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NalarAppBar(
        title: 'Cisco Packet Tracer Simulator',
        actions: [
          IconButton(
            icon: const Icon(Icons.cleaning_services_rounded, color: NalarColors.charcoal),
            tooltip: 'Clear Canvas',
            onPressed: () {
              setState(() {
                _devices.clear();
                _connections.clear();
                _pduLogs.insert(0, '[Canvas] Seluruh perangkat dan kabel dibersihkan.');
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Controls Bar (PDU ICMP Packet Launcher)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              color: NalarColors.white,
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: _pduSourceId,
                      decoration: const InputDecoration(
                        labelText: 'Source (PDU)',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      items: _devices.map((d) {
                        return DropdownMenuItem(
                          value: d.id,
                          child: Text('${d.name} (${d.ipAddress})', style: const TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _pduSourceId = val),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_rounded, color: NalarColors.primaryCoral, size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: _pduTargetId,
                      decoration: const InputDecoration(
                        labelText: 'Destination (PDU)',
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      items: _devices.map((d) {
                        return DropdownMenuItem(
                          value: d.id,
                          child: Text('${d.name} (${d.ipAddress})', style: const TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _pduTargetId = val),
                    ),
                  ),
                ],
              ),
            ),

            // Trigger PDU Packet Simulation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: NalarButton(
                text: _isSimulatingPdu ? 'Mengirim PDU Envelope...' : 'Simulasi ICMP PDU Packet Tracer',
                icon: Icons.mark_email_read_rounded,
                isLoading: _isSimulatingPdu,
                fullWidth: true,
                onPressed: _runPduSimulation,
              ),
            ),

            // Packet Tracer Grid Canvas
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF9F6), // Cisco Packet Tracer Grid Canvas Background
                  borderRadius: NalarRadius.borderLg,
                  border: Border.all(color: NalarColors.border),
                ),
                child: Stack(
                  children: [
                    // Canvas Grid Pattern Painter
                    CustomPaint(
                      size: Size.infinite,
                      painter: _PacketTracerGridPainter(_devices, _connections),
                    ),

                    // Draggable Devices with Link Status LEDs
                    ..._devices.map((dev) {
                      final isSelectedForConnect = dev.id == _connectModeSourceId;

                      return Positioned(
                        left: dev.position.dx,
                        top: dev.position.dy,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              dev.position += details.delta;
                            });
                          },
                          onTap: () {
                            if (_connectModeSourceId != null) {
                              // Complete Cable Connection
                              if (_connectModeSourceId != dev.id) {
                                _addConnection(_connectModeSourceId!, dev.id);
                              }
                              setState(() => _connectModeSourceId = null);
                            } else {
                              // Open Cisco Device Config Modal
                              _openCiscoDeviceConfigModal(dev);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isSelectedForConnect ? NalarColors.softCoral : Colors.white,
                              borderRadius: NalarRadius.borderMd,
                              border: Border.all(
                                color: isSelectedForConnect ? NalarColors.primaryCoral : NalarColors.border,
                                width: isSelectedForConnect ? 2 : 1,
                              ),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getDeviceIcon(dev.type),
                                      color: dev.isPortOn ? NalarColors.primaryCoral : Colors.grey,
                                      size: 26,
                                    ),
                                    const SizedBox(width: 4),
                                    // Link Status LED
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: dev.isPortOn ? Colors.green : Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(dev.name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                Text(dev.ipAddress, style: NalarTextStyles.caption),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Bottom Cisco Packet Tracer Device Palette Toolbar
            Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              color: const Color(0xFF2C3E50),
              child: Row(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PACKET TRACER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                      Text('PALETTE', style: TextStyle(color: NalarColors.brightCoral, fontWeight: FontWeight.bold, fontSize: 9)),
                    ],
                  ),
                  const VerticalDivider(color: Colors.white24, width: 16),

                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildPaletteItem('PC', Icons.computer_rounded, () => _addDevice('pc', 'PC')),
                        _buildPaletteItem('Laptop', Icons.laptop_rounded, () => _addDevice('laptop', 'Laptop')),
                        _buildPaletteItem('Switch 2960', Icons.hub_rounded, () => _addDevice('switch', 'Switch')),
                        _buildPaletteItem('Router 2911', Icons.router_rounded, () => _addDevice('router', 'Router')),
                        _buildPaletteItem('Server', Icons.dns_rounded, () => _addDevice('server', 'Server')),
                        const VerticalDivider(color: Colors.white24, width: 12),
                        _buildPaletteItem('Kabel UTP', Icons.cable_rounded, () {
                          if (_devices.isEmpty) return;
                          setState(() {
                            _connectModeSourceId = _devices.first.id;
                            _pduLogs.insert(0, '[Kabel UTP] Mode Sambung Kabel. Ketuk perangkat kedua.');
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Packet Tracer Log Table Console
            Container(
              height: 90,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: NalarRadius.borderMd,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Simulation Panel / PDU List', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  const Divider(color: Colors.white24, height: 6),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _pduLogs.length,
                      itemBuilder: (context, idx) {
                        return Text(
                          _pduLogs[idx],
                          style: const TextStyle(color: Colors.greenAccent, fontFamily: 'Monospace', fontSize: 10),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaletteItem(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 9)),
            ],
          ),
        ),
      ),
    );
  }

  void _addDevice(String type, String baseName) {
    final newId = 'dev_${DateTime.now().millisecondsSinceEpoch}';
    final count = _devices.where((d) => d.type == type).length + 1;
    final newDev = PtDevice(
      id: newId,
      name: '$baseName-$count',
      type: type,
      ipAddress: '192.168.1.${10 + _devices.length}',
      subnetMask: '255.255.255.0',
      position: Offset(50.0 + (_devices.length * 20), 80.0),
    );

    setState(() {
      _devices.add(newDev);
      _pduLogs.insert(0, '[Packet Tracer] Perangkat ${newDev.name} berhasil ditambahkan ke canvas.');
    });
  }

  void _addConnection(String fromId, String toId) {
    final connId = 'conn_${DateTime.now().millisecondsSinceEpoch}';
    setState(() {
      _connections.add(PtConnection(id: connId, fromDeviceId: fromId, toDeviceId: toId, cableType: 'straight'));
      _pduLogs.insert(0, '[Link] Kabel UTP tersambung dari $fromId ke $toId.');
    });
  }

  void _runPduSimulation() async {
    if (_pduSourceId == null || _pduTargetId == null) return;
    if (_pduSourceId == _pduTargetId) {
      setState(() => _pduLogs.insert(0, '[Warning] Perangkat asal dan tujuan PDU sama.'));
      return;
    }

    final src = _devices.firstWhere((d) => d.id == _pduSourceId);
    final dst = _devices.firstWhere((d) => d.id == _pduTargetId);

    setState(() {
      _isSimulatingPdu = true;
      _pduLogs.insert(0, '[ICMP PDU] Mengirim Envelope ICMP dari ${src.name} (${src.ipAddress}) -> ${dst.name} (${dst.ipAddress})...');
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      _isSimulatingPdu = false;
      _pduLogs.insert(0, '[Simulation Result] PDU Echo Reply dari ${dst.name}: SUCCESSFUL (Time <1ms)');
    });
  }

  void _openCiscoDeviceConfigModal(PtDevice dev) {
    final ipController = TextEditingController(text: dev.ipAddress);
    final subnetController = TextEditingController(text: dev.subnetMask);
    final nameController = TextEditingController(text: dev.name);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          decoration: const BoxDecoration(
            color: NalarColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_getDeviceIcon(dev.type), color: NalarColors.primaryCoral, size: 28),
                  const SizedBox(width: 10),
                  Text('Cisco Device Config: ${dev.name}', style: NalarTextStyles.heading2),
                ],
              ),
              const Divider(),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Host Name'),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: ipController,
                decoration: const InputDecoration(labelText: 'FastEthernet0/1 IP Address'),
              ),
              const SizedBox(height: 8),

              TextField(
                controller: subnetController,
                decoration: const InputDecoration(labelText: 'Subnet Mask'),
              ),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Port Status (FastEthernet0/1):', style: TextStyle(fontWeight: FontWeight.bold)),
                  Switch(
                    value: dev.isPortOn,
                    activeColor: NalarColors.success,
                    onChanged: (val) {
                      setState(() => dev.isPortOn = val);
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              NalarButton(
                text: 'Simpan Konfigurasi Cisco',
                icon: Icons.save_rounded,
                fullWidth: true,
                onPressed: () {
                  setState(() {
                    dev.name = nameController.text.trim();
                    dev.ipAddress = ipController.text.trim();
                    dev.subnetMask = subnetController.text.trim();
                    _pduLogs.insert(0, '[Cisco Config] IP ${dev.name} diperbarui menjadi ${dev.ipAddress}.');
                  });
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getDeviceIcon(String type) {
    switch (type) {
      case 'router':
        return Icons.router_rounded;
      case 'switch':
        return Icons.hub_rounded;
      case 'laptop':
        return Icons.laptop_rounded;
      case 'server':
        return Icons.dns_rounded;
      default:
        return Icons.computer_rounded;
    }
  }
}

// Packet Tracer Canvas Grid Painter
class _PacketTracerGridPainter extends CustomPainter {
  final List<PtDevice> devices;
  final List<PtConnection> connections;

  _PacketTracerGridPainter(this.devices, this.connections);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw Grid Lines
    final gridPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Draw Connection Cables with Link Status LED Lights
    final cablePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2;

    for (var conn in connections) {
      final dev1 = devices.firstWhere((d) => d.id == conn.fromDeviceId, orElse: () => devices.first);
      final dev2 = devices.firstWhere((d) => d.id == conn.toDeviceId, orElse: () => devices.first);

      final p1 = dev1.position + const Offset(25, 20);
      final p2 = dev2.position + const Offset(25, 20);

      canvas.drawLine(p1, p2, cablePaint);

      // Draw Cisco Link Status LEDs (Green triangle / circle at ends)
      final isBothUp = dev1.isPortOn && dev2.isPortOn;
      final ledPaint = Paint()..color = isBothUp ? Colors.green : Colors.red;

      canvas.drawCircle(p1, 4, ledPaint);
      canvas.drawCircle(p2, 4, ledPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
