import 'package:flutter/material.dart';
import '../../core/theme/nalar_colors.dart';
import '../../core/theme/nalar_text_styles.dart';
import '../../core/theme/nalar_radius.dart';
import '../../core/widgets/nalar_app_bar.dart';
import '../../core/widgets/nalar_button.dart';
import '../../core/widgets/nalar_card.dart';

class PcComponent {
  final String id;
  final String name;
  final String type;
  final String spec;
  final Color primaryColor;
  final IconData icon;

  PcComponent({
    required this.id,
    required this.name,
    required this.type,
    required this.spec,
    required this.primaryColor,
    required this.icon,
  });
}

class AssemblyStep {
  final int stepNumber;
  final String title;
  final String instruction;
  final String targetTypeId;

  AssemblyStep({
    required this.stepNumber,
    required this.title,
    required this.instruction,
    required this.targetTypeId,
  });
}

class PcAssemblySimulatorScreen extends StatefulWidget {
  const PcAssemblySimulatorScreen({super.key});

  @override
  State<PcAssemblySimulatorScreen> createState() => _PcAssemblySimulatorScreenState();
}

class _PcAssemblySimulatorScreenState extends State<PcAssemblySimulatorScreen> {
  int _currentStepIndex = 0;
  bool _isCompleted = false;
  String? _feedbackMessage;
  bool? _isFeedbackSuccess;

  // Track installed components on motherboard
  final Map<String, bool> _installedParts = {
    'psu': false,
    'mobo': false,
    'cpu': false,
    'ram': false,
    'ssd': false,
    'cooler': false,
  };

  final List<AssemblyStep> _steps = [
    AssemblyStep(
      stepNumber: 1,
      title: 'Langkah 1: Pasang Power Supply (PSU)',
      instruction: 'Pasang Power Supply Unit (PSU) ke kompartemen bawah Casing PC.',
      targetTypeId: 'psu',
    ),
    AssemblyStep(
      stepNumber: 2,
      title: 'Langkah 2: Pasang Motherboard ATX',
      instruction: 'Pasang Papan Utama Motherboard ke dalam Casing PC menggunakan baut standoff.',
      targetTypeId: 'mobo',
    ),
    AssemblyStep(
      stepNumber: 3,
      title: 'Langkah 3: Pasang Processor (CPU)',
      instruction: 'Buka kait socket LGA1700 dan tempatkan Processor CPU dengan presisi.',
      targetTypeId: 'cpu',
    ),
    AssemblyStep(
      stepNumber: 4,
      title: 'Langkah 4: Pasang Modul RAM DDR4',
      instruction: 'Buka klem slot DIMM memori dan tancapkan RAM hingga terkunci.',
      targetTypeId: 'ram',
    ),
    AssemblyStep(
      stepNumber: 5,
      title: 'Langkah 5: Pasang Storage M.2 NVMe SSD',
      instruction: 'Tancapkan modul M.2 NVMe SSD ke slot PCIe M.2 motherboard.',
      targetTypeId: 'ssd',
    ),
    AssemblyStep(
      stepNumber: 6,
      title: 'Langkah 6: Pasang Pendingin CPU Cooler',
      instruction: 'Pasang HSF CPU Cooler di atas permukaan prosessor untuk menjaga suhu.',
      targetTypeId: 'cooler',
    ),
  ];

  final List<PcComponent> _componentsTray = [
    PcComponent(
      id: 'mobo',
      name: 'Motherboard B560',
      type: 'mobo',
      spec: 'LGA1700, 4x DIMM, PCIe 4.0',
      primaryColor: const Color(0xFF2E3B4E),
      icon: Icons.developer_board_rounded,
    ),
    PcComponent(
      id: 'cpu',
      name: 'Intel Core i5-12400',
      type: 'cpu',
      spec: '6 Cores, 12 Threads, 4.4GHz',
      primaryColor: const Color(0xFF0071C5),
      icon: Icons.memory_rounded,
    ),
    PcComponent(
      id: 'ram',
      name: 'RAM DDR4 8GB 3200MHz',
      type: 'ram',
      spec: '288-Pin DIMM, Gold Contacts',
      primaryColor: const Color(0xFFD32F2F),
      icon: Icons.sd_card_rounded,
    ),
    PcComponent(
      id: 'ssd',
      name: 'NVMe M.2 SSD 512GB',
      type: 'ssd',
      spec: 'Read 3500MB/s, PCIe Gen3 x4',
      primaryColor: const Color(0xFF388E3C),
      icon: Icons.storage_rounded,
    ),
    PcComponent(
      id: 'psu',
      name: 'PSU 550W 80+ Bronze',
      type: 'psu',
      spec: 'ATX Power Supply, Braided Cables',
      primaryColor: const Color(0xFFF57C00),
      icon: Icons.power_rounded,
    ),
    PcComponent(
      id: 'cooler',
      name: 'Tower CPU Air Cooler',
      type: 'cooler',
      spec: '4 Heatpipes, 120mm PWM Fan',
      primaryColor: NalarColors.primaryCoral,
      icon: Icons.toys_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_isCompleted) {
      return _buildCompletionScreen();
    }

    final currentStep = _steps[_currentStepIndex];

    return Scaffold(
      appBar: const NalarAppBar(title: 'PC Assembly Simulator Visual'),
      body: SafeArea(
        child: Column(
          children: [
            // Top Step Progress Indicator
            LinearProgressIndicator(
              value: (_currentStepIndex + 1) / _steps.length,
              backgroundColor: NalarColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(NalarColors.primaryCoral),
              minHeight: 6,
            ),

            // Assembly Workspace Canvas (PC Case + Motherboard Visual)
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2638),
                  borderRadius: NalarRadius.borderXl,
                  border: Border.all(color: NalarColors.border),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    // Canvas Top Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentStep.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: NalarColors.primaryCoral,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Step ${_currentStepIndex + 1}/${_steps.length}',
                            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Graphical Assembly Board Canvas
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F1522),
                          borderRadius: NalarRadius.borderLg,
                          border: Border.all(color: Colors.white12),
                        ),
                        child: CustomPaint(
                          painter: _MotherboardVisualPainter(installedParts: _installedParts),
                          child: Stack(
                            children: [
                              // Visual Overlay labels for motherboard sockets
                              if (!_installedParts['mobo']!)
                                const Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo_outlined, size: 48, color: Colors.white24),
                                      SizedBox(height: 8),
                                      Text(
                                        'Area Casing Komputer (Kosong)',
                                        style: TextStyle(color: Colors.white38, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Instruction Banner & Feedback
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: NalarCard(
                padding: const EdgeInsets.all(12),
                backgroundColor: _isFeedbackSuccess == true
                    ? NalarColors.success.withOpacity(0.12)
                    : (_isFeedbackSuccess == false
                        ? NalarColors.primaryCoral.withOpacity(0.12)
                        : NalarColors.softCoral),
                borderColor: _isFeedbackSuccess == true
                    ? NalarColors.success
                    : (_isFeedbackSuccess == false ? NalarColors.primaryCoral : NalarColors.border),
                child: Row(
                  children: [
                    Icon(
                      _isFeedbackSuccess == true
                          ? Icons.check_circle_rounded
                          : (_isFeedbackSuccess == false ? Icons.error_rounded : Icons.info_outline_rounded),
                      color: _isFeedbackSuccess == true
                          ? NalarColors.success
                          : (_isFeedbackSuccess == false ? NalarColors.primaryCoral : NalarColors.primaryCoral),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _feedbackMessage ?? currentStep.instruction,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _isFeedbackSuccess == true
                              ? NalarColors.success
                              : (_isFeedbackSuccess == false ? NalarColors.primaryCoral : NalarColors.charcoal),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Component Selection Tray (Visual Component Cards)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Pilih Gambar Komponen Hardware:', style: NalarTextStyles.heading3),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              flex: 3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: _componentsTray.length,
                itemBuilder: (context, index) {
                  final part = _componentsTray[index];
                  final isInstalled = _installedParts[part.type] ?? false;

                  return Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 8),
                    child: InkWell(
                      onTap: isInstalled ? null : () => _handleComponentTap(part, currentStep),
                      borderRadius: NalarRadius.borderLg,
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isInstalled ? Colors.grey.shade200 : NalarColors.white,
                          borderRadius: NalarRadius.borderLg,
                          border: Border.all(
                            color: isInstalled ? Colors.grey.shade400 : part.primaryColor,
                            width: 1.5,
                          ),
                          boxShadow: [
                            if (!isInstalled)
                              BoxShadow(
                                color: part.primaryColor.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Graphical Icon Visual Badge
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isInstalled ? Colors.grey.shade300 : part.primaryColor.withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                part.icon,
                                color: isInstalled ? Colors.grey : part.primaryColor,
                                size: 36,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              part.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: isInstalled ? Colors.grey : NalarColors.charcoal,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              part.spec,
                              style: TextStyle(fontSize: 10, color: isInstalled ? Colors.grey : NalarColors.secondaryText),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: isInstalled ? Colors.grey : part.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                isInstalled ? 'Terpasang' : 'Pasang Part',
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
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

  void _handleComponentTap(PcComponent part, AssemblyStep currentStep) {
    if (part.type == currentStep.targetTypeId) {
      setState(() {
        _installedParts[part.type] = true;
        _isFeedbackSuccess = true;
        _feedbackMessage = 'Tepat Sekali! Visual ${part.name} berhasil terpasang pada motherboard.';
      });

      Future.delayed(const Duration(milliseconds: 900), () {
        if (_currentStepIndex < _steps.length - 1) {
          setState(() {
            _currentStepIndex++;
            _feedbackMessage = null;
            _isFeedbackSuccess = null;
          });
        } else {
          setState(() {
            _isCompleted = true;
          });
        }
      });
    } else {
      setState(() {
        _isFeedbackSuccess = false;
        _feedbackMessage = 'Part kurang tepat untuk langkah ini. Pilih komponen "${currentStep.title}".';
      });
    }
  }

  Widget _buildCompletionScreen() {
    return Scaffold(
      appBar: const NalarAppBar(title: 'Perakitan PC Selesai'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: NalarColors.softCoral,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, size: 72, color: NalarColors.primaryCoral),
              ),
              const SizedBox(height: 20),
              Text('PC Desktop Berhasil Dirakit!', style: NalarTextStyles.heading1, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              const Text(
                'Seluruh komponen utama (PSU, Motherboard, CPU, RAM, SSD, Cooler) telah terpasang dengan presisi.',
                textAlign: TextAlign.center,
                style: NalarTextStyles.bodyMedium,
              ),
              const SizedBox(height: 32),
              NalarButton(
                text: 'Ulangi Simulasi Perakitan',
                icon: Icons.refresh_rounded,
                type: NalarButtonType.outlined,
                fullWidth: true,
                onPressed: () {
                  setState(() {
                    _currentStepIndex = 0;
                    _isCompleted = false;
                    _feedbackMessage = null;
                    _isFeedbackSuccess = null;
                    _installedParts.updateAll((key, value) => false);
                  });
                },
              ),
              const SizedBox(height: 12),
              NalarButton(
                text: 'Kembali ke Pilihan Simulasi',
                icon: Icons.arrow_back_rounded,
                type: NalarButtonType.primary,
                fullWidth: true,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter for PC Assembly Motherboard Blueprint & Components
class _MotherboardVisualPainter extends CustomPainter {
  final Map<String, bool> installedParts;

  _MotherboardVisualPainter({required this.installedParts});

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Draw PC Case Enclosure
    final casePaint = Paint()
      ..color = const Color(0xFF1B2230)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)), casePaint);

    final caseBorderPaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(8)), caseBorderPaint);

    // 2. Draw Power Supply Unit (PSU) at bottom if installed
    if (installedParts['psu']!) {
      final psuRect = Rect.fromLTWH(10, size.height - 60, size.width - 20, 50);
      final psuPaint = Paint()..color = const Color(0xFF37474F);
      canvas.drawRRect(RRect.fromRectAndRadius(psuRect, const Radius.circular(6)), psuPaint);

      final psuFanPaint = Paint()..color = Colors.black45;
      canvas.drawCircle(psuRect.center, 18, psuFanPaint);

      TextPainter(
        text: const TextSpan(text: 'PSU 550W 80+ BRONZE (POWER OK)', style: TextStyle(color: Colors.amberAccent, fontSize: 10, fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
      )..layout()..paint(canvas, Offset(20, size.height - 35));
    }

    // 3. Draw Motherboard Board PCB if installed
    if (installedParts['mobo']!) {
      final moboRect = Rect.fromLTWH(20, 15, size.width - 40, size.height - 85);
      final moboPaint = Paint()..color = const Color(0xFF1B3B2B); // Dark Green/Black PCB
      canvas.drawRRect(RRect.fromRectAndRadius(moboRect, const Radius.circular(6)), moboPaint);

      final moboBorder = Paint()
        ..color = const Color(0xFF388E3C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(RRect.fromRectAndRadius(moboRect, const Radius.circular(6)), moboBorder);

      // CPU Socket Area (LGA1700)
      final socketRect = Rect.fromLTWH(moboRect.left + 30, moboRect.top + 25, 60, 60);
      final socketPaint = Paint()..color = const Color(0xFF424242);
      canvas.drawRect(socketRect, socketPaint);

      // Draw CPU Processor if installed
      if (installedParts['cpu']!) {
        final cpuRect = Rect.fromLTWH(socketRect.left + 5, socketRect.top + 5, 50, 50);
        final cpuPaint = Paint()..color = const Color(0xFFB0BEC5); // Metallic IHS Lid
        canvas.drawRect(cpuRect, cpuPaint);

        TextPainter(
          text: const TextSpan(text: 'INTEL\ni5-12400', style: TextStyle(color: Colors.black87, fontSize: 8, fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
        )..layout()..paint(canvas, Offset(cpuRect.left + 8, cpuRect.top + 14));
      }

      // Draw RAM DIMM Slots & installed RAM
      final ramSlotRect = Rect.fromLTWH(socketRect.right + 20, moboRect.top + 20, 16, 75);
      final ramSlotPaint = Paint()..color = Colors.black;
      canvas.drawRect(ramSlotRect, ramSlotPaint);

      if (installedParts['ram']!) {
        final ramStickRect = Rect.fromLTWH(ramSlotRect.left + 2, ramSlotRect.top + 2, 12, 71);
        final ramPaint = Paint()..color = const Color(0xFFD32F2F); // Red Heatsink RAM
        canvas.drawRect(ramStickRect, ramPaint);

        TextPainter(
          text: const TextSpan(text: 'RAM DDR4', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
        )..layout()..paint(canvas, Offset(ramStickRect.left + 1, ramStickRect.top + 25));
      }

      // Draw M.2 NVMe SSD Slot & installed SSD
      final ssdSlotRect = Rect.fromLTWH(moboRect.left + 20, socketRect.bottom + 25, 80, 16);
      final ssdSlotPaint = Paint()..color = Colors.black54;
      canvas.drawRect(ssdSlotRect, ssdSlotPaint);

      if (installedParts['ssd']!) {
        final ssdStickRect = Rect.fromLTWH(ssdSlotRect.left + 2, ssdSlotRect.top + 2, 76, 12);
        final ssdPaint = Paint()..color = const Color(0xFF2E7D32); // Green NVMe PCB
        canvas.drawRect(ssdStickRect, ssdPaint);

        TextPainter(
          text: const TextSpan(text: 'NVMe 512GB', style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
        )..layout()..paint(canvas, Offset(ssdStickRect.left + 10, ssdStickRect.top + 1));
      }

      // Draw CPU Air Cooler Fan if installed
      if (installedParts['cooler']!) {
        final coolerCenter = socketRect.center;
        final coolerPaint = Paint()..color = NalarColors.primaryCoral.withOpacity(0.85);
        canvas.drawCircle(coolerCenter, 32, coolerPaint);

        final fanBlades = Paint()
          ..color = Colors.white
          ..strokeWidth = 3;
        canvas.drawLine(coolerCenter - const Offset(20, 20), coolerCenter + const Offset(20, 20), fanBlades);
        canvas.drawLine(coolerCenter - const Offset(-20, 20), coolerCenter + const Offset(-20, 20), fanBlades);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
