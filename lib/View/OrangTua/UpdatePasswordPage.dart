import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/Model/OrangTua/UpdatePasswordRequest.dart';
import 'package:sina_mobile/View/Component/CustomAppBarNoDrawer.dart';
import 'package:sina_mobile/ViewModel/OrangTua/UbahPasswordViewModel.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart'; // Tambahkan ini

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarNoDrawer(),
      body: Consumer<UbahPasswordViewModel>(
        builder: (context, vm, _) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ubah Kata Sandi",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(thickness: 5, color: Colors.blue),
                const SizedBox(height: 20),

                buildPasswordField(
                  "Kata Sandi Sekarang",
                  _currentPasswordController,
                  _obscureCurrent,
                  () {
                    setState(() => _obscureCurrent = !_obscureCurrent);
                  },
                ),
                const SizedBox(height: 15),
                buildPasswordField(
                  "Kata Sandi Baru",
                  _newPasswordController,
                  _obscureNew,
                  () {
                    setState(() => _obscureNew = !_obscureNew);
                  },
                ),
                const SizedBox(height: 15),
                buildPasswordField(
                  "Konfirmasi Kata Sandi Baru",
                  _confirmPasswordController,
                  _obscureConfirm,
                  () {
                    setState(() => _obscureConfirm = !_obscureConfirm);
                  },
                ),

                const Spacer(),

                vm.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                      onPressed: () async {
                        final current = _currentPasswordController.text.trim();
                        final newPass = _newPasswordController.text.trim();
                        final confirm = _confirmPasswordController.text.trim();

                        if (current.isEmpty ||
                            newPass.isEmpty ||
                            confirm.isEmpty) {
                          showSnackBar(
                            context,
                            "Gagal",
                            "Semua field harus diisi",
                            ContentType.failure,
                          );
                          return;
                        }

                        if (newPass != confirm) {
                          showSnackBar(
                            context,
                            "Gagal",
                            "Konfirmasi password tidak cocok",
                            ContentType.failure,
                          );
                          return;
                        }

                        final request = UpdatePasswordRequest(
                          password_lama: current,
                          password_baru: newPass,
                          konfirmasi_password: confirm,
                        );

                        try {
                          await vm.ubahPassword(request);
                          if (!context.mounted) return;
                          showSnackBar(
                            context,
                            "Berhasil",
                            "Password berhasil diperbarui",
                            ContentType.success,
                          );
                          Navigator.pop(context);
                        } catch (e) {
                          if (!context.mounted) return;
                          showSnackBar(
                            context,
                            "Gagal",
                            "Gagal mengubah password",
                            ContentType.failure,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Batalkan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildPasswordField(
    String label,
    TextEditingController controller,
    bool obscure,
    VoidCallback toggleObscure,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: 'Ketik di sini',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            suffixIcon: IconButton(
              icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
              onPressed: toggleObscure,
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(
    BuildContext context,
    String title,
    String message,
    ContentType type,
  ) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
