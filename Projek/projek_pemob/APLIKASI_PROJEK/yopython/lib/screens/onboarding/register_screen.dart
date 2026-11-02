import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/common.dart';
import 'target_screen.dart';
import '../home/main_shell.dart';

/// 03 Registrasi: pilihan Daftar | Masuk dan form. StatefulWidget karena ada input.
///
/// Versi tampilan: form hanya divalidasi, lalu pindah ke Home.
/// Saat API Laravel siap, isi [_submit] dengan POST /api/register atau /api/login.
class RegisterScreen extends StatefulWidget {
  final int dailyGoalXp;
  final bool startWithLogin;
  const RegisterScreen({super.key, this.dailyGoalXp = 20, this.startWithLogin = false});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  late int mode = widget.startWithLogin ? 1 : 0; // 0 = Daftar, 1 = Masuk
  bool hidePass = true;

  bool get isRegister => mode == 0;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const MainShell()), (_) => false);
  }

  void _forgot() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur atur ulang kata sandi aktif setelah aplikasi terhubung ke server.')),
    );
  }

  InputDecoration _deco(String hint, {Widget? suffix}) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: AppColors.surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
    suffixIcon: suffix,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      borderSide: const BorderSide(color: AppColors.control),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      borderSide: const BorderSide(color: AppColors.accent, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      borderSide: const BorderSide(color: AppColors.neg),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppTheme.radius),
      borderSide: const BorderSide(color: AppColors.neg, width: 2),
    ),
  );

  Widget _label(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 14),
    child: Text(t, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Column(
            children: [
              const OnboardTop(progress: 1),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  children: [
                    SegmentedChoice(
                      options: const ['Daftar', 'Masuk'],
                      selected: mode,
                      onChanged: (i) => setState(() => mode = i),
                    ),
                    const SizedBox(height: 16),
                    Text(isRegister ? 'Buat akunmu' : 'Masuk ke akunmu', style: AppText.h1),
                    const SizedBox(height: 6),
                    Text(
                      isRegister
                          ? 'Simpan progres dan streak-mu di perangkat mana pun.'
                          : 'Lanjutkan streak dan progres belajarmu.',
                      style: AppText.lead,
                    ),
                    if (isRegister) ...[
                      _label('Nama panggilan'),
                      TextFormField(
                        controller: _name,
                        textInputAction: TextInputAction.next,
                        decoration: _deco('Contoh: Rina'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama panggilan wajib diisi' : null,
                      ),
                    ],
                    _label('Email'),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: _deco('nama@email.com'),
                      validator: (v) {
                        final t = v?.trim() ?? '';
                        if (t.isEmpty) return 'Email wajib diisi';
                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t)) return 'Format email belum benar';
                        return null;
                      },
                    ),
                    _label('Kata sandi'),
                    TextFormField(
                      controller: _pass,
                      obscureText: hidePass,
                      decoration: _deco(
                        'Minimal 8 karakter',
                        suffix: IconButton(
                          tooltip: hidePass ? 'Tampilkan kata sandi' : 'Sembunyikan kata sandi',
                          icon: Icon(hidePass ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                          onPressed: () => setState(() => hidePass = !hidePass),
                        ),
                      ),
                      validator: (v) => (v == null || v.length < 8) ? 'Kata sandi minimal 8 karakter' : null,
                    ),
                    if (!isRegister)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: _forgot,
                          style: TextButton.styleFrom(foregroundColor: AppColors.ink, padding: EdgeInsets.zero),
                          child: const Text('Lupa kata sandi?', style: TextStyle(fontWeight: FontWeight.w600)),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: AppButton(isRegister ? 'Daftar' : 'Masuk', onPressed: _submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}