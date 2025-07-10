// ... (import tetap sama)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/OrangTua/RegisterInitResponse.dart';
import 'package:sina_mobile/View/RegisterFinalPage.dart';
import 'package:sina_mobile/ViewModel/OrangTua/RegisterViewModel.dart';
import 'package:device_info_plus/device_info_plus.dart';

class TokenVerifikasiPage extends StatefulWidget {
  final String nis;
  final String statusOrtu;
  final RegisterData? registerData;

  const TokenVerifikasiPage({
    super.key,
    required this.nis,
    required this.statusOrtu,
    this.registerData,
  });

  @override
  State<TokenVerifikasiPage> createState() => _TokenVerifikasiPageState();
}

class _TokenVerifikasiPageState extends State<TokenVerifikasiPage> {
  final _controllers = List.generate(6, (_) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;
  String _imei = '';

  @override
  void initState() {
    super.initState();
    _getImei();
  }

  Future<void> _getImei() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    setState(() {
      _imei = androidInfo.id ?? 'unknown_imei';
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerViewModel = Provider.of<RegisterViewModel>(context);
    final email = widget.registerData?.emailOrtu ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi OTP')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Image.asset('lib/asset/image/loginLogo.png', height: 100),
                const SizedBox(height: 16),
                const Text(
                  'Masukkan 6 digit kode OTP yang dikirim ke email Anda',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 45,
                      child: TextField(
                        controller: _controllers[index],
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (val) {
                          if (val.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (val.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed:
                        registerViewModel.isLoading
                            ? null
                            : () async {
                              final otp =
                                  _controllers.map((c) => c.text).join();
                              if (otp.length != 6) {
                                setState(() {
                                  _errorMessage = 'OTP harus 6 digit';
                                });
                                return;
                              }

                              try {
                                final success = await registerViewModel
                                    .validateOtp(
                                      nis: widget.nis,
                                      statusOrtu: widget.statusOrtu,
                                      otp: otp,
                                      email: email,
                                    );

                                if (!success) {
                                  setState(() {
                                    _errorMessage = 'Kode OTP tidak Sesuai';
                                  });
                                  return;
                                }

                                if (mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (_) => RegisterFinalPage(
                                            nis: widget.nis,
                                            statusOrtu: widget.statusOrtu,
                                            imei: _imei,
                                          ),
                                    ),
                                  );
                                }
                              } catch (e) {
                                setState(() {
                                  _errorMessage = e.toString().replaceAll(
                                    'Exception: ',
                                    '',
                                  );
                                });
                              }
                            },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2F66F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        registerViewModel.isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              'Lanjutkan',
                              style: TextStyle(color: Colors.white),
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
