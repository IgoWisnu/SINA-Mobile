import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/Component/CustomAppBar.dart';
import 'package:sina_mobile/View/Component/CustomDropdown.dart';
import 'package:sina_mobile/View/Component/Custom_drawer.dart';
import 'package:sina_mobile/View/Lib/Colors.dart';
import 'package:sina_mobile/ViewModel/Guru/NilaiRaporViewModel.dart';
import '../Model/Guru/NilaiRaporModel.dart';

class ListRapotSiswa extends StatefulWidget {
  const ListRapotSiswa({super.key});

  @override
  State<ListRapotSiswa> createState() => _ListRapotSiswaState();
}

class _ListRapotSiswaState extends State<ListRapotSiswa> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String currentMenu = 'rapot';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<NilaiRaporViewModel>(
        context,
        listen: false,
      );
      if (viewModel.mapelList.isEmpty) {
        viewModel.fetchMapel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(selectedMenu: currentMenu),
      appBar: CustomAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      body: Consumer<NilaiRaporViewModel>(
        builder: (context, viewModel, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildHeader(viewModel),
                const SizedBox(height: 10),
                if (viewModel.isLoading && viewModel.siswaList.isEmpty)
                  const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (viewModel.errorMessage.isNotEmpty)
                  Expanded(child: Center(child: Text(viewModel.errorMessage)))
                else
                  Expanded(
                    child: Column(
                      children: [
                        _buildListHeader(),
                        Expanded(
                          child: ListView.builder(
                            itemCount: viewModel.siswaList.length,
                            itemBuilder: (context, index) {
                              final siswa = viewModel.siswaList[index];
                              return _buildSiswaItem(siswa, viewModel);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(NilaiRaporViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "List Rapot Siswa",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            SizedBox(
              width: 150,
              child: CustomDropdown(
                items: viewModel.mapelList.map((e) => e.namaMapel).toList(),
                selectedItem:
                    viewModel.selectedMapel?.namaMapel ?? 'Pilih Mapel',
                onChanged: (newValue) {
                  final selected = viewModel.mapelList.firstWhere(
                    (e) => e.namaMapel == newValue,
                  );
                  viewModel.selectMapel(selected);
                },
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 150,
              child: CustomDropdown(
                items: viewModel.kelasList.map((e) => e.namaKelas).toList(),
                selectedItem:
                    viewModel.selectedKelas?.namaKelas ?? 'Pilih Kelas',
                onChanged: (newValue) {
                  final selected = viewModel.kelasList.firstWhere(
                    (e) => e.namaKelas == newValue,
                  );
                  viewModel.selectKelas(selected);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildListHeader() {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(
              width: 40,
              child: Text(
                "No",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Siswa",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: Text(
                "Status",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSiswaItem(SiswaNilai siswa, NilaiRaporViewModel viewModel) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: SizedBox(
          width: 40,
          child: Text(
            (viewModel.siswaList.indexOf(siswa) + 1).toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(siswa.namaSiswa),
        trailing: _buildStatusIndicator(siswa.status),
        onTap: () => _navigateToDetail(siswa, viewModel),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    final Map<String, Map<String, dynamic>> statusData = {
      'selesai': {'icon': Icons.check_circle, 'color': Colors.green},
      'draf': {'icon': Icons.edit, 'color': Colors.orange},
      'belum': {'icon': Icons.circle, 'color': Colors.grey},
    };

    final statusLower = status.toLowerCase();
    final IconData icon =
        statusData[statusLower]?['icon'] as IconData? ?? Icons.circle;
    final Color color =
        statusData[statusLower]?['color'] as Color? ?? Colors.grey;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          status.toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _navigateToDetail(SiswaNilai siswa, NilaiRaporViewModel viewModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                DetailRapotSiswa(siswa: siswa, mapel: viewModel.selectedMapel!),
      ),
    );
  }
}

class DetailRapotSiswa extends StatefulWidget {
  final SiswaNilai siswa;
  final Mapel mapel;

  const DetailRapotSiswa({required this.siswa, required this.mapel, Key? key})
    : super(key: key);

  @override
  State<DetailRapotSiswa> createState() => _DetailRapotSiswaState();
}

class _DetailRapotSiswaState extends State<DetailRapotSiswa> {
  final _formKey = GlobalKey<FormState>();
  final _nilaiController = TextEditingController();
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = widget.siswa.status.toLowerCase();
    _nilaiController.text = widget.siswa.nilai?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Nilai Rapot'),
        actions: [
          if (_status == 'selesai')
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.lock, color: Colors.grey),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              const SizedBox(height: 24),
              _buildNilaiInputField(),
              const SizedBox(height: 24),
              _buildStatusChip(),
              const SizedBox(height: 32),
              if (_status == 'belum' || _status == 'draf')
                _buildActionButtons(),
              if (_status == 'selesai') _buildLockedMessage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nama Siswa', widget.siswa.namaSiswa),
            const Divider(height: 24),
            _buildInfoRow('Mata Pelajaran', widget.mapel.namaMapel),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildNilaiInputField() {
    return TextFormField(
      controller: _nilaiController,
      decoration: InputDecoration(
        labelText: 'Nilai',
        border: const OutlineInputBorder(),
        suffixText: '/100',
        hintText: 'Masukkan nilai 0-100',
      ),
      keyboardType: TextInputType.number,
      readOnly: _status == 'selesai',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Harap masukkan nilai';
        }
        final nilai = int.tryParse(value);
        if (nilai == null || nilai < 0 || nilai > 100) {
          return 'Nilai harus antara 0-100';
        }
        return null;
      },
    );
  }

  Widget _buildStatusChip() {
    final color = _status == 'selesai' ? Colors.green : Colors.orange;
    return Chip(
      label: Text(_status.toUpperCase(), style: TextStyle(color: Colors.white)),
      backgroundColor: color,
      avatar: Icon(
        _status == 'selesai' ? Icons.check : Icons.edit,
        color: Colors.white,
        size: 18,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitAsDraft,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('SIMPAN SEBAGAI DRAFT'),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitAndComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('SIMPAN DAN SELESAIKAN'),
          ),
        ),
      ],
    );
  }

  Widget _buildLockedMessage() {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.lock_outline, size: 48, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Nilai sudah dikunci dan tidak dapat diubah',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAsDraft() async {
    if (!_formKey.currentState!.validate()) return;
    await _submitNilai(status: 'draf');
  }

  Future<void> _submitAndComplete() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _status = 'selesai');
    await _submitNilai(status: 'selesai');
  }

  Future<void> _submitNilai({required String status}) async {
    final viewModel = Provider.of<NilaiRaporViewModel>(context, listen: false);
    final nilai = int.parse(_nilaiController.text);

    final success = await viewModel.submitNilai(
      krsId: widget.siswa.krsId,
      nilai: nilai,
      status: status,
      mapelId: widget.mapel.mapelId,
    );

    if (success && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Nilai berhasil disimpan!')));
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nilaiController.dispose();
    super.dispose();
  }
}
