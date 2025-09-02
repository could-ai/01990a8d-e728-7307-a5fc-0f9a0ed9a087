import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Ekonomi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        cardTheme: CardTheme(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const EconomicsCalculator(),
    );
  }
}

class EconomicsCalculator extends StatelessWidget {
  const EconomicsCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kalkulator Soal Ekonomi'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Fungsi Permintaan'),
              Tab(text: 'Fungsi Penawaran'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DemandScreen(),
            SupplyScreen(),
          ],
        ),
      ),
    );
  }
}

class DemandScreen extends StatefulWidget {
  const DemandScreen({super.key});

  @override
  State<DemandScreen> createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> {
  final TextEditingController _pxController = TextEditingController();
  final TextEditingController _pzController = TextEditingController();
  String _demandResult = '';

  void _calculateDemand() {
    final double? px = double.tryParse(_pxController.text);
    final double? pz = double.tryParse(_pzController.text);

    if (px != null && pz != null) {
      // Qd = 6500 - 0.5Px + 9Pz
      final double qd = 6500 - (0.5 * px) + (9 * pz);
      setState(() {
        _demandResult = 'Jumlah barang X yang dapat dibeli (Qd) adalah ${qd.toStringAsFixed(2)} unit.';
      });
    } else {
      setState(() {
        _demandResult = 'Harap masukkan nilai Px dan Pz yang valid.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InfoCard(
              title: '1. Analisis Fungsi Permintaan',
              content:
                  'Qd = 6.000 - 1/2Px - Py + 9Pz + 1/10M\nDiketahui: Py = \$6.500, M = \$70.000',
            ),
            const InfoCard(
              title: 'a) Hubungan Antar Barang',
              content:
                  '• Barang Y adalah KOMPLEMENTER terhadap barang X karena koefisien Py (-1) negatif.\n• Barang Z adalah SUBSTITUSI terhadap barang X karena koefisien Pz (+9) positif.',
            ),
            const InfoCard(
              title: 'b) Sifat Barang X',
              content:
                  '• Barang X adalah barang NORMAL karena koefisien M (+1/10) positif, artinya permintaan naik saat pendapatan (M) naik.',
            ),
            const InfoCard(
              title: 'd) Fungsi Permintaan dan Invers',
              content:
                  'Substitusi Py dan M:\nQd = 6000 - 0.5Px - 6500 + 9Pz + 0.1(70000)\nFungsi Permintaan: Qd = 6500 - 0.5Px + 9Pz\nFungsi Invers: Px = 13000 - 2Qd + 18Pz',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'c) Hitung Jumlah Barang X',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pxController,
                      decoration: const InputDecoration(
                        labelText: 'Harga Barang X (Px)',
                        hintText: 'Contoh: 5250',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pzController,
                      decoration: const InputDecoration(
                        labelText: 'Harga Barang Z (Pz)',
                        hintText: 'Masukkan harga barang Z',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _calculateDemand,
                      child: const Text('Hitung Qd'),
                    ),
                    const SizedBox(height: 16),
                    if (_demandResult.isNotEmpty)
                      Text(
                        _demandResult,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SupplyScreen extends StatefulWidget {
  const SupplyScreen({super.key});

  @override
  State<SupplyScreen> createState() => _SupplyScreenState();
}

class _SupplyScreenState extends State<SupplyScreen> {
  final TextEditingController _pxControllerA =
      TextEditingController(text: '600');
  final TextEditingController _pzControllerA =
      TextEditingController(text: '60');
  String _supplyResultA = '';

  final TextEditingController _pxControllerB =
      TextEditingController(text: '80');
  final TextEditingController _pzControllerB =
      TextEditingController(text: '60');
  String _supplyResultB = '';

  @override
  void initState() {
    super.initState();
    _calculateSupplyA();
    _calculateSupplyB();
  }

  void _calculateSupplyA() {
    final double? px = double.tryParse(_pxControllerA.text);
    final double? pz = double.tryParse(_pzControllerA.text);
    if (px != null && pz != null) {
      final double qs = -30 + (2 * px) - pz;
      setState(() {
        _supplyResultA = 'Jumlah yang ditawarkan (Qs) = ${qs.toStringAsFixed(0)} unit';
      });
    }
  }

  void _calculateSupplyB() {
    final double? px = double.tryParse(_pxControllerB.text);
    final double? pz = double.tryParse(_pzControllerB.text);
    if (px != null && pz != null) {
      final double qs = -30 + (2 * px) - pz;
      setState(() {
        _supplyResultB = 'Jumlah yang ditawarkan (Qs) = ${qs.toStringAsFixed(0)} unit';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const InfoCard(
              title: '2. Analisis Fungsi Penawaran',
              content: 'Qs = -30 + 2Px - Pz',
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'a) Hitung Jumlah Penawaran (Contoh 1)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pxControllerA,
                      decoration: const InputDecoration(labelText: 'Harga Barang X (Px)'),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _calculateSupplyA(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pzControllerA,
                      decoration: const InputDecoration(labelText: 'Harga Barang Z (Pz)'),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _calculateSupplyA(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _supplyResultA,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'b) Hitung Jumlah Penawaran (Contoh 2)',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pxControllerB,
                      decoration: const InputDecoration(labelText: 'Harga Barang X (Px)'),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _calculateSupplyB(),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _pzControllerB,
                      decoration: const InputDecoration(labelText: 'Harga Barang Z (Pz)'),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => _calculateSupplyB(),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _supplyResultB,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const InfoCard(
              title: 'c) Fungsi Penawaran (jika Pz = \$60)',
              content:
                  'Qs = -30 + 2Px - 60\nFungsi Penawaran: Qs = -90 + 2Px',
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
