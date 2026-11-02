import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import '../../widgets/common.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void goRegister({required bool login}) => showSoon(context, login ? 'Masuk' : 'Daftar');

    return Scaffold(
      backgroundColor: AppColors.ink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 56,
                child: Row(children: [
                  const YoMark(size: 32, color: Color(0xFF7CC4D6)),
                  const SizedBox(width: 8),
                  const Text('YoPython',
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  TextButton(
                    onPressed: () => goRegister(login: false),
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    child: const Text('Lewati', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                ]),
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Belajar Python lewat kuis singkat',
                            style:
                            TextStyle(color: Colors.white, fontSize: 34, height: 1.1, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        const Text('Tiga sampai lima menit sehari. Tanpa mengetik kode: susun, isi, dan tebak.',
                            style: TextStyle(color: Color(0xD9FFFFFF), fontSize: 16, height: 1.5)),
                        const SizedBox(height: 28),
                        const _HeroCard(),
                      ],
                    ),
                  ),
                ),
              ),
              AppButton('Mulai belajar', kind: BtnKind.white, onPressed: () => showSoon(context, 'Target Harian')),
              TextButton(
                onPressed: () => goRegister(login: true),
                style: TextButton.styleFrom(foregroundColor: Colors.white, minimumSize: const Size.fromHeight(48)),
                child: const Text('Saya sudah punya akun', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    Widget line(String t) => Container(
      height: 44,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.control),
        borderRadius: BorderRadius.circular(AppTheme.radius),
      ),
      child: Text(t, style: AppText.mono),
    );
    return CardBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Soal 1 dari 5 · Susun kode', style: AppText.small),
        const SizedBox(height: 6),
        const Text('Susun baris agar mencetak 5', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        line('total = 0'),
        line('print(total)'),
        line('total = total + 5'),
      ]),
    );
  }
}