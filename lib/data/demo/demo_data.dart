import '../models/module_model.dart';
import '../models/quiz_model.dart';
import '../models/device_model.dart';
import '../models/borrowing_model.dart';
import '../models/project_model.dart';
import '../models/notification_model.dart';
import '../models/video_model.dart';

class DemoData {
  static List<LearningModule> get modules => [
        LearningModule(
          id: 1,
          title: 'Pengenalan TJKT',
          description: 'Memahami ruang lingkup keahlian Teknologi Jaringan Komputer dan Telekomunikasi.',
          iconName: 'lan',
          estimatedTime: '1.5 Jam',
          objective: 'Siswa dapat menjelaskan konsep dasar TJKT, profesi di bidang jaringan, dan perkembangan teknologi komunikasi.',
          subChapters: [
            SubChapter(
              id: '1_1',
              title: '1. Apa itu TJKT?',
              content: 'Teknologi Jaringan Komputer dan Telekomunikasi (TJKT) adalah bidang keahlian yang mempelajari cara menghubungkan perangkat komputer dan sistem komunikasi agar dapat saling berbagi data, informasi, dan sumber daya secara aman dan cepat.\n\nDalam era digital, TJKT menjadi fondasi utama seluruh infrastruktur internet, pusat data (data center), dan layanan telekomunikasi seluler.',
            ),
            SubChapter(
              id: '1_2',
              title: '2. Prospek Karir TJKT',
              content: 'Lulusan TJKT memiliki peluang kerja yang luas di industri teknologi, antara lain:\n- Network Engineer: Merancang dan mengelola jaringan komputer perusahaan.\n- System Administrator: Mengatur server dan sistem operasi jaringan.\n- Cybersecurity Specialist: Menjaga keamanan data dari serangan kiber.\n- Field Technician: Memasang infrastruktur kabel dan perangkat telekomunikasi.',
            ),
            SubChapter(
              id: '1_3',
              title: '3. Perkembangan Teknologi Komunikasi',
              content: 'Perkembangan jaringan telah berevolusi dari jaringan kabel sederhana hingga komunikasi nirkabel berkecepatan tinggi seperti 5G dan serat optik (Fiber Optic). Pemahaman fondasi TJKT sangat penting untuk mengikuti perkembangan komputasi awan (Cloud Computing) dan Internet of Things (IoT).',
            ),
          ],
        ),
        LearningModule(
          id: 2,
          title: 'Dasar-Dasar Komputer',
          description: 'Mengenal prinsip kerja perangkat komputer dan sejarah perkembangannya.',
          iconName: 'computer',
          estimatedTime: '2 Jam',
          objective: 'Siswa memahami komponen pemrosesan data, arsitektur Von Neumann, dan alur kerja input-proses-output.',
          subChapters: [
            SubChapter(
              id: '2_1',
              title: '1. Prinsip Kerja Komputer',
              content: 'Komputer bekerja berdasarkan siklus IPO (Input - Process - Output):\n1. Input: Menerima data dari pengguna melalui keyboard/mouse.\n2. Process: Mengolah data di CPU dan RAM.\n3. Output: Menampilkan hasil pada layar monitor atau printer.\n4. Storage: Menyimpan hasil ke SSD atau Harddisk.',
            ),
            SubChapter(
              id: '2_2',
              title: '2. Arsitektur Von Neumann',
              content: 'Arsitektur Von Neumann terdiri dari tiga bagian utama:\n- Control Unit (CU) & Arithmetic Logic Unit (ALU) di dalam CPU.\n- Memori Utama (RAM) untuk menyimpan data sementara.\n- Perangkat Input/Output untuk interaksi eksternal.',
            ),
          ],
        ),
        LearningModule(
          id: 3,
          title: 'Sistem Komputer',
          description: 'Memahami interaksi antara Hardware, Software, dan Brainware.',
          iconName: 'memory',
          estimatedTime: '2 Jam',
          objective: 'Siswa dapat mengidentifikasi pilar utama sistem komputer dan perannya masing-masing.',
          subChapters: [
            SubChapter(
              id: '3_1',
              title: '1. Tiga Pilar Sistem Komputer',
              content: 'Sistem komputer dapat berfungsi jika ketiga pilar ini bekerja sama:\n- Hardware (Perangkat Keras): Komponen fisik yang bisa disentuh.\n- Software (Perangkat Lunak): Program dan instruksi perintah.\n- Brainware (Pengguna): Manusia yang mengoperasikan sistem.',
            ),
            SubChapter(
              id: '3_2',
              title: '2. Hirarki Memori',
              content: 'Memori komputer disusun berdasarkan kecepatan dan kapasitas:\n- Register CPU (tercepat, kapasitas paling kecil).\n- Cache Memory (L1, L2, L3).\n- RAM (RAM DDR4/DDR5).\n- Secondary Storage (SSD, HDD).',
            ),
          ],
        ),
        LearningModule(
          id: 4,
          title: 'Perangkat Keras dan Perangkat Lunak',
          description: 'Kategori hardware komputer serta jenis-jenis software sistem dan aplikasi.',
          iconName: 'devices',
          estimatedTime: '2.5 Jam',
          objective: 'Siswa mampu membedakan jenis-jenis hardware dan mengklasifikasikan software.',
          subChapters: [
            SubChapter(
              id: '4_1',
              title: '1. Pengelompokan Hardware',
              content: 'Hardware dikelompokkan menjadi:\n- Input Devices: Keyboard, Mouse, Scanner, Barcode Reader.\n- Processing Devices: Processor (CPU), GPU, Motherboard.\n- Output Devices: Monitor, Speaker, Printer.\n- Storage Devices: NVMe SSD, HDD, Flash Drive.',
            ),
            SubChapter(
              id: '4_2',
              title: '2. Pengelompokan Software',
              content: 'Software terbagi menjadi:\n- System Software: Sistem Operasi (Windows, Linux, macOS).\n- Application Software: Web Browser, Office, Graphic Tool.\n- Utility Software: Antivirus, Disk Cleaner, Archiver.',
            ),
          ],
        ),
        LearningModule(
          id: 5,
          title: 'Dasar Jaringan Komputer',
          description: 'Konsep dasar interkoneksi, cakupan wilayah (LAN, MAN, WAN), dan Model OSI.',
          iconName: 'router',
          estimatedTime: '3 Jam',
          objective: 'Siswa memahami pengertian jaringan, jenis jangkauan geografis, dan 7 Lapisan OSI Layer.',
          subChapters: [
            SubChapter(
              id: '5_1',
              title: '1. Pengertian & Manfaat Jaringan',
              content: 'Jaringan komputer adalah kumpulan dua atau lebih komputer yang terhubung untuk saling berbagi sumber daya (file, printer, koneksi internet).\n\nManfaat utama:\n- Resource Sharing\n- Komunikasi Cepat\n- Keamanan Data Terpusat',
            ),
            SubChapter(
              id: '5_2',
              title: '2. Jenis Jaringan Berdasarkan Wilayah',
              content: '- PAN (Personal Area Network): Jangkauan sangat dekat (Bluetooth, hotspot pribadi).\n- LAN (Local Area Network): Jangkauan satu ruangan/gedung sekolah.\n- MAN (Metropolitan Area Network): Jangkauan antargedung dalam satu kota.\n- WAN (Wide Area Network): Jangkauan antarnegara/benua (Internet).',
            ),
            SubChapter(
              id: '5_3',
              title: '3. Model OSI Layer',
              content: 'OSI (Open Systems Interconnection) memiliki 7 lapisan:\n7. Application\n6. Presentation\n5. Session\n4. Transport\n3. Network\n2. Data Link\n1. Physical',
            ),
          ],
        ),
        LearningModule(
          id: 6,
          title: 'Topologi Jaringan',
          description: 'Mengenal bentuk fisik dan logika susunan jaringan komputer.',
          iconName: 'hub',
          estimatedTime: '2.5 Jam',
          objective: 'Siswa mampu menganalisis kelebihan dan kekurangan topologi Star, Bus, Ring, dan Mesh.',
          subChapters: [
            SubChapter(
              id: '6_1',
              title: '1. Topologi Star',
              content: 'Topologi Star menggunakan perangkat pusat (Switch/Hub) sebagai konsentrasi sambungan.\n\nKelebihan:\n- Mudah menambah perangkat baru.\n- Jika 1 kabel putus, komputer lain tidak terganggu.\n\nKekurangan:\n- Jika Switch pusat rusak, seluruh jaringan lumpuh.',
            ),
            SubChapter(
              id: '6_2',
              title: '2. Topologi Bus, Ring, & Mesh',
              content: '- Bus: Menggunakan satu kabel Coaxial utama (kabel backbone). Murah namun rentan kolisi data.\n- Ring: Data mengalir melingkar satu arah secara berurutan.\n- Mesh: Setiap perangkat terhubung langsung ke perangkat lainnya. Sangat tangguh (redundant) tapi mahal.',
            ),
          ],
        ),
        LearningModule(
          id: 7,
          title: 'Perangkat Jaringan',
          description: 'Fungsi dan perbedaan Router, Switch, Access Point, Modem, dan Network Interface Card.',
          iconName: 'alt_route',
          estimatedTime: '2.5 Jam',
          objective: 'Siswa dapat menjelaskan fungsi tiap hardware jaringan dan posisi penggunaannya.',
          subChapters: [
            SubChapter(
              id: '7_1',
              title: '1. Router vs Switch',
              content: '- Router: Bekerja pada Layer 3 (Network). Berfungsi menghubungkan dua atau lebih jaringan yang berbeda IP subnet (misalnya LAN ke Internet).\n- Switch: Bekerja pada Layer 2 (Data Link). Berfungsi menghubungkan banyak komputer dalam satu jaringan lokal (LAN).',
            ),
            SubChapter(
              id: '7_2',
              title: '2. Perangkat Nirkabel & Modem',
              content: '- Access Point (AP): Menyediakan pemancar gelombang radio Wi-Fi untuk klien nirkabel.\n- Modem (Modulator Demodulator): Mengubah sinyal digital menjadi sinyal analog dari ISP dan sebaliknya.',
            ),
          ],
        ),
        LearningModule(
          id: 8,
          title: 'Media Transmisi',
          description: 'Mempelajari media transmisi kabel (UTP, STP, FO) dan nirkabel (Wi-Fi, Radio).',
          iconName: 'cable',
          estimatedTime: '2 Jam',
          objective: 'Siswa paham standar pengkabelan UTP (Straight & Cross) serta karakteristik Fiber Optic.',
          subChapters: [
            SubChapter(
              id: '8_1',
              title: '1. Kabel UTP & Standar T568B',
              content: 'Kabel UTP (Unshielded Twisted Pair) berisi 8 warna kabel.\nStandar T568B (Urutan Warna):\n1. Putih-Orange\n2. Orange\n3. Putih-Hijau\n4. Biru\n5. Putih-Biru\n6. Hijau\n7. Putih-Cokelat\n8. Cokelat\n\nKabel Straight-Through digunakan untuk menghubungkan dua perangkat BERBEDA jenis (contoh: PC ke Switch).',
            ),
            SubChapter(
              id: '8_2',
              title: '2. Fiber Optic (Serat Optik)',
              content: 'Fiber Optic mentransmisikan data dalam bentuk pulsa cahaya melalui serat kaca tipis.\n\nKelebihan FO:\n- Kecepatan sangat tinggi (Gbps).\n- Tahan gangguan gelombang elektromagnetik.\n- Jangkauan transmisi sangat jauh tanpa repeater.',
            ),
          ],
        ),
        LearningModule(
          id: 9,
          title: 'IP Address dan Subnetting Dasar',
          description: 'Pengalamatan IPv4, kelas IP, subnet mask, dan perhitungan subnetting sederhana.',
          iconName: 'dns',
          estimatedTime: '3.5 Jam',
          objective: 'Siswa dapat menghitung subnetting kelas C, menentukan Network ID, Broadcast ID, dan Host ID.',
          subChapters: [
            SubChapter(
              id: '9_1',
              title: '1. Struktur IPv4',
              content: 'IPv4 terdiri dari 32 bit biner yang dibagi menjadi 4 oktet (masing-masing 8 bit).\nContoh: 192.168.1.1\n\nKelas IP IPv4:\n- Kelas A: 1.0.0.0 - 126.255.255.255 (Jaringan Sangat Besar)\n- Kelas B: 128.0.0.0 - 191.255.255.255 (Jaringan Menengah)\n- Kelas C: 192.0.0.0 - 223.255.255.255 (Jaringan Lokal/Kecil)',
            ),
            SubChapter(
              id: '9_2',
              title: '2. Subnetting /24 (CIDR)',
              content: 'Subnet Mask /24 berarti 255.255.255.0.\n- Total IP address = 256.\n- IP Network = 192.168.1.0\n- IP Broadcast = 192.168.1.255\n- IP Usable Host = 192.168.1.1 hingga 192.168.1.254 (Total 254 Host).',
            ),
          ],
        ),
        LearningModule(
          id: 10,
          title: 'Sistem Operasi',
          description: 'Pengenalan sistem operasi desktop dan server (Windows & Linux).',
          iconName: 'settings_suggest',
          estimatedTime: '2.5 Jam',
          objective: 'Siswa memahami peran OS, perintah CLI dasar Linux, dan manajemen sistem.',
          subChapters: [
            SubChapter(
              id: '10_1',
              title: '1. Peran Sistem Operasi',
              content: 'Sistem Operasi (OS) bertindak sebagai perantara antara pengguna dan hardware komputer. OS mengelola memori, prosesor, sistem file, dan hak akses keamanan.',
            ),
            SubChapter(
              id: '10_2',
              title: '2. Perintah Dasar CLI Linux',
              content: 'Perintah terminal Linux penting dalam TJKT:\n- `ls` : Menampilkan isi direktori\n- `cd` : Pindah direktori\n- `mkdir` : Membuat folder baru\n- `ifconfig` / `ip a` : Melihat konfigurasi IP jaringan\n- `ping` : Menguji koneksi jaringan',
            ),
          ],
        ),
        LearningModule(
          id: 11,
          title: 'Dasar Telekomunikasi',
          description: 'Prinsip transmisi sinyal, gelombang frekuensi radio, dan komunikasi jaringan seluler.',
          iconName: 'cell_tower',
          estimatedTime: '2.5 Jam',
          objective: 'Siswa membedakan sinyal analog dan digital serta prinsip komunikasi gelombang radio.',
          subChapters: [
            SubChapter(
              id: '11_1',
              title: '1. Sinyal Analog vs Sinyal Digital',
              content: '- Sinyal Analog: Sinyal gelombang kontinyu (seperti gelombang suara manusia).\n- Sinyal Digital: Sinyal biner dalam bentuk pulsa diskrit 0 dan 1.',
            ),
            SubChapter(
              id: '11_2',
              title: '2. Evolusi Seluler (1G hingga 5G)',
              content: '- 1G: Panggilan suara analog.\n- 2G (GSM): Layanan SMS & data dasar.\n- 3G: Akses web & video call awal.\n- 4G (LTE): Layanan internet pita lebar (Broadband).\n- 5G: Ultra-low latency & kecepatan multi-gigabit.',
            ),
          ],
        ),
        LearningModule(
          id: 12,
          title: 'K3 Laboratorium TJKT',
          description: 'Keselamatan dan Kesehatan Kerja di Laboratorium Komputer dan Jaringan.',
          iconName: 'health_and_safety',
          estimatedTime: '1.5 Jam',
          objective: 'Siswa dapat menerapkan standar prosedur K3L saat perakitan PC, instalasi kabel, dan penggunaan peralatan listrik.',
          subChapters: [
            SubChapter(
              id: '12_1',
              title: '1. Bahaya Listrik & Listrik Statis',
              content: 'Sebelum menyentuh komponen internal komputer (Motherboard, RAM), pastikan memutus arus listrik dan menyentuh bagian logam casing untuk membuang muatan elektrostatik (ESD) yang dapat merusak komponen sensitif.',
            ),
            SubChapter(
              id: '12_2',
              title: '2. Prosedur Aman Menggunakan Crimping Tool',
              content: '- Gunakan tang crimping dengan hati-hati saat memotong kabel UTP.\n- Selalu gunakan kacamata pelindung jika memotong serat kaca Fiber Optic.\n- Jaga kebersihan sisa potongan kabel di area kerja laboratorium.',
            ),
          ],
        ),
      ];

  static List<QuizQuestion> get quizQuestions => [
        // Module 1 Quiz
        QuizQuestion(
          id: 'q1_1',
          moduleId: 1,
          question: 'Apa kepanjangan dari TJKT?',
          options: [
            'Teknologi Jaringan Komputer dan Telekomunikasi',
            'Teknik Jaringan Komunikasi Terpadu',
            'Teknologi Komputer dan Komunikasi Terkini',
            'Teknik Komputer dan Jaringan Terdistribusi',
          ],
          correctAnswerIndex: 0,
          explanation: 'TJKT merupakan singkatan resmi dari Teknologi Jaringan Komputer dan Telekomunikasi pada kurikulum SMK.',
        ),
        QuizQuestion(
          id: 'q1_2',
          moduleId: 1,
          question: 'Profesi yang bertugas mengamankan jaringan dari serangan kiber adalah...',
          options: [
            'System Administrator',
            'Cybersecurity Specialist',
            'Web Developer',
            'Graphic Designer',
          ],
          correctAnswerIndex: 1,
          explanation: 'Cybersecurity Specialist bertanggung jawab khusus atas keamanan sistem dan jaringan kiber.',
        ),

        // Module 5 Quiz
        QuizQuestion(
          id: 'q5_1',
          moduleId: 5,
          question: 'Jaringan yang mencakup area terbatas seperti dalam satu ruangan laboratorium sekolah disebut...',
          options: [
            'MAN',
            'WAN',
            'LAN',
            'PAN',
          ],
          correctAnswerIndex: 2,
          explanation: 'LAN (Local Area Network) menghubungkan perangkat dalam skala area lokal/terbatas.',
        ),
        QuizQuestion(
          id: 'q5_2',
          moduleId: 5,
          question: 'Berapa jumlah lapisan (layer) dalam model referensi OSI?',
          options: ['5', '6', '7', '8'],
          correctAnswerIndex: 2,
          explanation: 'Model OSI terdiri dari 7 lapisan (Physical hingga Application).',
        ),

        // Module 6 Quiz
        QuizQuestion(
          id: 'q6_1',
          moduleId: 6,
          question: 'Topologi yang menggunakan Switch/Hub sebagai pusat sambungan kabel adalah...',
          options: ['Topologi Bus', 'Topologi Star', 'Topologi Ring', 'Topologi Mesh'],
          correctAnswerIndex: 1,
          explanation: 'Topologi Star menghubungkan setiap node langsung ke satu pusat kontrol yaitu Switch/Hub.',
        ),

        // Module 8 Quiz
        QuizQuestion(
          id: 'q8_1',
          moduleId: 8,
          question: 'Urutan warna kabel UTP standar T568B untuk urutan pin 1 dan pin 2 adalah...',
          options: [
            'Putih-Hijau dan Hijau',
            'Putih-Orange dan Orange',
            'Putih-Biru dan Biru',
            'Putih-Cokelat dan Cokelat',
          ],
          correctAnswerIndex: 1,
          explanation: 'Standar T568B dimulai dengan urutan: 1. Putih-Orange, 2. Orange.',
        ),
        QuizQuestion(
          id: 'q8_2',
          moduleId: 8,
          question: 'Perangkat apa yang terhubung menggunakan kabel UTP tipe Straight-Through?',
          options: [
            'PC ke PC',
            'Switch ke Switch',
            'PC ke Switch',
            'Router ke Router',
          ],
          correctAnswerIndex: 2,
          explanation: 'Kabel Straight-Through digunakan untuk menghubungkan dua perangkat yang BERBEDA jenis (PC ke Switch).',
        ),

        // Module 9 Quiz
        QuizQuestion(
          id: 'q9_1',
          moduleId: 9,
          question: 'Berapa jumlah total alamat IP pada prefix /24?',
          options: ['128', '256', '512', '1024'],
          correctAnswerIndex: 1,
          explanation: 'Subnet mask /24 memiliki 256 total IP address (254 dapat dipakai host, 1 IP Network, 1 IP Broadcast).',
        ),
      ];

  static List<DeviceItem> get devices => [
        DeviceItem(
          id: 'dev_1',
          name: 'Router MikroTik',
          category: DeviceCategory.network,
          description: 'Perangkat cerdas pengarah lalu lintas data antar jaringan yang berbeda subnet.',
          functionText: 'Menghubungkan jaringan lokal (LAN) ke jaringan luar (Internet) serta mengatur bandwidth dan firewall.',
          exampleUsage: 'Digunakan di laboratorium sekolah untuk mendistribusikan koneksi internet ke setiap ruangan.',
          iconName: 'router',
        ),
        DeviceItem(
          id: 'dev_2',
          name: 'Switch Unmanaged',
          category: DeviceCategory.network,
          description: 'Perangkat konsentrator kabel LAN layer 2.',
          functionText: 'Menghubungkan banyak PC dalam satu segmen LAN yang sama secara plug-and-play.',
          exampleUsage: 'Menghubungkan 24 PC praktikum di Lab TJKT ke server lokal.',
          iconName: 'hub',
        ),
        DeviceItem(
          id: 'dev_3',
          name: 'Kabel UTP Cat6',
          category: DeviceCategory.cable,
          description: 'Kabel pasangan berpilin tanpa pelindung tembaga.',
          functionText: 'Media transmisi data kabel berkecepatan hingga 10 Gbps untuk jarak pendek-menengah.',
          exampleUsage: 'Koneksi dari stopkontak dinding ke PC siswa.',
          iconName: 'cable',
        ),
        DeviceItem(
          id: 'dev_4',
          name: 'Konektor RJ45',
          category: DeviceCategory.cable,
          description: 'Konektor fisik 8-pin untuk kabel UTP/STP.',
          functionText: 'Terminal penyambung kabel UTP yang dipasang ke port Ethernet NIC / Switch.',
          exampleUsage: 'Dipasang pada ujung kabel UTP menggunakan Tang Crimping.',
          iconName: 'settings_input_hdmi',
        ),
        DeviceItem(
          id: 'dev_5',
          name: 'Motherboard ATX',
          category: DeviceCategory.computer,
          description: 'Papan sirkuit utama sistem komputer.',
          functionText: 'Menghubungkan CPU, RAM, VGA, SSD, dan periferal lainnya agar saling berkomunikasi.',
          exampleUsage: 'Papan utama tempat memasang Processor dan modul RAM.',
          iconName: 'developer_board',
        ),
        DeviceItem(
          id: 'dev_6',
          name: 'CPU / Processor Intel Core i5',
          category: DeviceCategory.computer,
          description: 'Unit Pemrosesan Sentral (Otak Komputer).',
          functionText: 'Mengeksekusi instruksi aritmatika, logika, dan kontrol sistem.',
          exampleUsage: 'Memproses perhitungan komputasi dan instruksi sistem operasi.',
          iconName: 'memory',
        ),
        DeviceItem(
          id: 'dev_7',
          name: 'Access Point Wi-Fi 6',
          category: DeviceCategory.telecom,
          description: 'Perangkat pemancar sinyal nirkabel WLAN.',
          functionText: 'Memancarkan sinyal Wi-Fi untuk menghubungkan smartphone dan laptop siswa.',
          exampleUsage: 'Dipasang di langit-langit ruang kelas TJKT.',
          iconName: 'wifi',
        ),
        DeviceItem(
          id: 'dev_8',
          name: 'Kabel Fiber Optic Single Mode',
          category: DeviceCategory.cable,
          description: 'Media transmisi optik berbahan kaca super murni.',
          functionText: 'Mengirimkan data berbasis cahaya untuk jarak sangat jauh tanpa distorsi.',
          exampleUsage: 'Kabel backbone utama penyedia layanan ISP ke sekolah.',
          iconName: 'grain',
        ),
        DeviceItem(
          id: 'dev_9',
          name: 'RAM DDR4 8GB',
          category: DeviceCategory.computer,
          description: 'Memori akses acak sementara berkecepatan tinggi.',
          functionText: 'Menyimpan data instruksi aplikasi yang sedang aktif dijalankan.',
          exampleUsage: 'Memungkinkan multitasking sistem berjalan lancar.',
          iconName: 'sd_card',
        ),
        DeviceItem(
          id: 'dev_10',
          name: 'NVMe M.2 SSD 512GB',
          category: DeviceCategory.computer,
          description: 'Perangkat penyimpanan non-volatile berbasis chip flash.',
          functionText: 'Menyimpan sistem operasi, program aplikasi, dan data siswa secara permanen.',
          exampleUsage: 'Booting Windows dalam hitungan detik.',
          iconName: 'storage',
        ),
      ];

  static List<EquipmentItem> get labEquipment => [
        EquipmentItem(
          id: 'eq_1',
          name: 'Crimping Tool RJ45',
          category: 'Toolkit Pengkabelan',
          condition: 'Baik',
          isAvailable: true,
          description: 'Tang krimp khusus untuk memotong, mengupas, dan mengunci konektor RJ45 pada kabel UTP.',
          iconName: 'build',
        ),
        EquipmentItem(
          id: 'eq_2',
          name: 'LAN Tester Network',
          category: 'Pengujian',
          condition: 'Baik',
          isAvailable: true,
          description: 'Alat penguji kontinuitas 8 pin kabel UTP/STP dengan indikator lampu LED.',
          iconName: 'fact_check',
        ),
        EquipmentItem(
          id: 'eq_3',
          name: 'Router MikroTik hEX gr3',
          category: 'Perangkat Jaringan',
          condition: 'Baik',
          isAvailable: true,
          description: 'Router 5 port Gigabit untuk latihan konfigurasi Routing, Winbox, dan Firewall.',
          iconName: 'router',
        ),
        EquipmentItem(
          id: 'eq_4',
          name: 'Switch Cisco Catalyst 2960',
          category: 'Perangkat Jaringan',
          condition: 'Baik',
          isAvailable: true,
          description: 'Managed Switch 24 port untuk praktikum VLAN dan Trunking.',
          iconName: 'hub',
        ),
        EquipmentItem(
          id: 'eq_5',
          name: 'Access Point TP-Link',
          category: 'Perangkat Nirkabel',
          condition: 'Baik',
          isAvailable: true,
          description: 'Access Point Dual-Band untuk simulasi jaringan hotspot dan wireless security.',
          iconName: 'wifi',
        ),
        EquipmentItem(
          id: 'eq_6',
          name: 'Kabel UTP Roll (10 Meter)',
          category: 'Bahan Praktikum',
          condition: 'Baru',
          isAvailable: true,
          description: 'Potongan kabel Cat6 10 meter untuk praktikum pengkabelan.',
          iconName: 'cable',
        ),
        EquipmentItem(
          id: 'eq_7',
          name: 'Fusion Splicer Fiber Optic',
          category: 'Peralatan FO',
          condition: 'Perlu Perhatian',
          isAvailable: true,
          description: 'Alat penyambung serat optik dengan pemanas inti serat kaca presisi.',
          iconName: 'architecture',
        ),
      ];

  static List<StudentProject> get studentProjects => [
        StudentProject(
          id: 'proj_1',
          title: 'Rancangan Jaringan LAN Kelas X TJKT',
          description: 'Merancang topologi star dan melakukan simulasi alamat IP untuk 20 komputer laboratorium.',
          objective: 'Siswa dapat menentukan kebutuhan perangkat, membuat bagan topologi, dan menetapkan alokasi IP.',
          targetDate: '25 Oktober 2026',
          checklist: [
            ProjectChecklistItem(id: 'c1_1', taskName: 'Menentukan jumlah host dan subnet mask', isCompleted: true),
            ProjectChecklistItem(id: 'c1_2', taskName: 'Menggambar skema topologi star di simulasi', isCompleted: true),
            ProjectChecklistItem(id: 'c1_3', taskName: 'Menyusun tabel alokasi IP Address', isCompleted: false),
            ProjectChecklistItem(id: 'c1_4', taskName: 'Menguji konektivitas ping antar perangkat', isCompleted: false),
          ],
          studentNotes: 'Sudah menyelesaikan perhitungan IP subnetting /27.',
        ),
        StudentProject(
          id: 'proj_2',
          title: 'Pembuatan Kabel UTP Straight & Cross',
          description: 'Praktikum merakit kabel UTP dengan konektor RJ45 dan menguji sambungan dengan LAN Tester.',
          objective: 'Siswa mampu mengupas kabel, mengurutkan warna standar T568B, dan meremukkan krimp dengan benar.',
          targetDate: '30 Oktober 2026',
          checklist: [
            ProjectChecklistItem(id: 'c2_1', taskName: 'Mempersiapkan UTP, RJ45, dan Tang Crimping', isCompleted: true),
            ProjectChecklistItem(id: 'c2_2', taskName: 'Mengurutkan warna sesuai standar T568B', isCompleted: true),
            ProjectChecklistItem(id: 'c2_3', taskName: 'Mengunci konektor dengan Tang Crimping', isCompleted: false),
            ProjectChecklistItem(id: 'c2_4', taskName: 'Menguji indikator lampu 1-8 pada LAN Tester', isCompleted: false),
          ],
          studentNotes: '',
        ),
        StudentProject(
          id: 'proj_3',
          title: 'Simulasi Perakitan PC Lab TJKT',
          description: 'Latihan memasang komponen prosessor, RAM, motherboard, dan penyimpanan pada simulasi perakitan.',
          objective: 'Memahami urutan perakitan hardware PC secara tepat dan aman.',
          targetDate: '05 November 2026',
          checklist: [
            ProjectChecklistItem(id: 'c3_1', taskName: 'Memasang CPU dan Thermal Paste ke Motherboard', isCompleted: true),
            ProjectChecklistItem(id: 'c3_2', taskName: 'Memasang RAM pada slot dual channel', isCompleted: true),
            ProjectChecklistItem(id: 'c3_3', taskName: 'Memasang SSD M.2 NVMe', isCompleted: true),
            ProjectChecklistItem(id: 'c3_4', taskName: 'Memasang Power Supply & Pengkabelan Daya', isCompleted: false),
          ],
          studentNotes: 'Perlu memperhatikan penguncian klem socket prosessor.',
        ),
      ];

  static List<NalarNotification> get initialNotifications => [
        NalarNotification(
          id: 'notif_1',
          title: 'Selamat Datang di NALAR!',
          body: 'Aplikasi NALAR siap menemani kegiatan belajar TJKT kamu. Explore Technology. Connect Your Future.',
          category: NotificationCategory.learning,
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          isRead: true,
        ),
        NalarNotification(
          id: 'notif_2',
          title: 'Pengingat Streak Belajar',
          body: 'Kamu telah belajar 7 hari berturut-turut! Pertahankan streak kamu hari ini.',
          category: NotificationCategory.learning,
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
          isRead: false,
        ),
        NalarNotification(
          id: 'notif_3',
          title: 'Praktikum Jaringan',
          body: 'Jangan lupa menyelesaikan checklist proyek "Rancangan Jaringan LAN Kelas X TJKT".',
          category: NotificationCategory.project,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          isRead: false,
        ),
      ];

  static const Map<String, String> aiKnowledgeBase = {
    'router':
        'Router adalah perangkat jaringan layer 3 (Network Layer) yang berfungsi menghubungkan dua atau lebih jaringan yang memiliki segmen IP berbeda (misalnya menghubungkan jaringan lokal LAN dengan internet). Router mengarahkan rute paket data menggunakan tabel routing.',
    'switch':
        'Switch adalah perangkat jaringan layer 2 (Data Link Layer) yang berfungsi menghubungkan beberapa komputer atau perangkat dalam satu jaringan lokal (LAN) yang sama.',
    'kabel utp':
        'Kabel UTP (Unshielded Twisted Pair) adalah kabel tembaga berpilin yang umum digunakan pada jaringan LAN. Urutan warna T568B standar: Putih-Orange, Orange, Putih-Hijau, Biru, Putih-Biru, Hijau, Putih-Cokelat, Cokelat.',
    'subnetting':
        'Subnetting adalah teknik membagi satu jaringan IP besar menjadi beberapa sub-jaringan (subnet) yang lebih kecil agar pengelolaan IP lebih efisien, hemat alamat, dan aman.',
    'ip address':
        'IP Address (Internet Protocol Address) adalah deretan angka biner/desimal yang menjadi identitas unik setiap komputer/perangkat yang terhubung ke jaringan agar dapat saling berkomunikasi.',
    'topologi star':
        'Topologi Star adalah bentuk jaringan di mana setiap komputer terhubung langsung ke satu pusat kontrol berupa Switch atau Hub. Jika satu kabel PC putus, jaringan lain tidak terganggu.',
    'osi layer':
        'Model OSI memiliki 7 lapisan: 1. Physical, 2. Data Link, 3. Network, 4. Transport, 5. Session, 6. Presentation, 7. Application.',
    'k3':
        'Prinsip K3 (Keselamatan & Kesehatan Kerja) di Lab TJKT meliputi melepaskan arus listrik sebelum perakitan, membuang muatan listrik statis tubuh, menggunakan tang crimping secara aman, dan memakai kacamata pelindung saat memotong serat kaca Fiber Optic.',
  };

  static List<TjktVideo> get tjktVideos => [
        TjktVideo(
          id: 'v1',
          title: 'Tutorial Pengkabelan UTP Straight & Cross (T568B)',
          description: 'Panduan praktikum membuat kabel UTP dengan konektor RJ45 sesuai urutan warna standar T568B dan pengujian LAN tester.',
          youtubeUrl: 'https://www.youtube.com/watch?v=3QhU9jd03a0',
          youtubeVideoId: '3QhU9jd03a0',
          duration: '12:45',
          category: 'Jaringan',
        ),
        TjktVideo(
          id: 'v2',
          title: 'Dasar Konfigurasi MikroTik Winbox untuk Pemula',
          description: 'Langkah demi langkah mengkonfigurasi IP Address, DHCP Server, dan NAT Outgoing pada Router MikroTik.',
          youtubeUrl: 'https://www.youtube.com/watch?v=k2_8rO8s9S0',
          youtubeVideoId: 'k2_8rO8s9S0',
          duration: '18:20',
          category: 'MikroTik',
        ),
        TjktVideo(
          id: 'v3',
          title: 'Cara Cepat & Mudah Belajar Subnetting IPv4 CIDR',
          description: 'Penjelasan rumus menghitung prefix /24 hingga /30, menentukan Network ID, Broadcast ID, dan Usable IP.',
          youtubeUrl: 'https://www.youtube.com/watch?v=vcArbdO4p4I',
          youtubeVideoId: 'vcArbdO4p4I',
          duration: '15:10',
          category: 'Subnetting',
        ),
        TjktVideo(
          id: 'v4',
          title: 'Mengenal Komponen Hardware PC & Fungsi Utama',
          description: 'Visualisasi dan fungsi Motherboard, Processor, RAM DDR4, NVMe SSD, PSU, dan CPU Cooler.',
          youtubeUrl: 'https://www.youtube.com/watch?v=ExxFxD4XA24',
          youtubeVideoId: 'ExxFxD4XA24',
          duration: '14:30',
          category: 'Hardware',
        ),
        TjktVideo(
          id: 'v5',
          title: 'Simulasi Cisco Packet Tracer: VLAN & Inter-VLAN Routing',
          description: 'Latihan membuat topologi jaringan kampus/sekolah menggunakan Switch Managed dan Router Cisco.',
          youtubeUrl: 'https://www.youtube.com/watch?v=p1L3Q8fD2A0',
          youtubeVideoId: 'p1L3Q8fD2A0',
          duration: '22:15',
          category: 'Jaringan',
        ),
        TjktVideo(
          id: 'v6',
          title: 'Teknik Sambung Serat Optik dengan Fusion Splicer',
          description: 'Tutorial praktikum pemotongan serat kaca, persiapan klem, dan proses penyambungan kabel Fiber Optic.',
          youtubeUrl: 'https://www.youtube.com/watch?v=Y8k8c2L19e8',
          youtubeVideoId: 'Y8k8c2L19e8',
          duration: '16:05',
          category: 'Fiber Optic',
        ),
      ];
}
