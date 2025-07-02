import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sina_mobile/View/OrangTua/DashboardOrangTua.dart';
import '../ViewModel/AuthViewModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  String? emailError;
  String? passwordError;

  final sqlKeywords = [
    'select',
    'drop',
    'insert',
    'update',
    'delete',
    '--',
    ';',
  ];

  bool containsSqlInjection(String input) {
    final lower = input.toLowerCase();
    return sqlKeywords.any((keyword) => lower.contains(keyword));
  }

  void validateAndLogin(AuthViewModel vm) async {
    setState(() {
      emailError = null;
      passwordError = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    bool hasError = false;

    if (email.isEmpty) {
      emailError = 'Email tidak boleh kosong';
      hasError = true;
    } else if (containsSqlInjection(email)) {
      emailError = 'Email mengandung karakter tidak valid';
      hasError = true;
    }

    if (password.isEmpty) {
      passwordError = 'Kata sandi tidak boleh kosong';
      hasError = true;
    } else if (containsSqlInjection(password)) {
      passwordError = 'Kata sandi mengandung karakter tidak valid';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    final success = await vm.login(email, password);

    if (success) {
      if (!mounted) return;

      final role =
          vm.user?.data.role
              .toLowerCase(); // Pastikan vm.user sudah diset setelah login

      if (role == 'ortu') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Dashboardorangtua()),
        );
      } else {
        setState(() {
          passwordError = 'Peran tidak dikenali: $role';
        });
      }
    } else {
      setState(() {
        passwordError = 'Login gagal. Periksa kembali email dan password anda';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'lib/asset/image/loginLogo.png',
                  height: 200,
                  width: 300,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Masuk ke akun Anda',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),

                // Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: emailController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: 'Masukan Email Anda',
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    if (emailError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          emailError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),

                // Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kata Sandi',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        counterText: '',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    if (passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          passwordError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),

                vm.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => validateAndLogin(vm),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F66F8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                const SizedBox(height: 16),

                // Link ke registrasi
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/regisPage');
                  },
                  child: const Text(
                    'Mendaftar Orang Tua',
                    style: TextStyle(
                      color: Color(0xFF2F66F8),
                      fontWeight: FontWeight.w500,
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
