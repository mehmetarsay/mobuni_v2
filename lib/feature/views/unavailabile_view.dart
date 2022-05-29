import 'package:mobuni_v2/core/components/app_bar/custom_app_bar.dart';

import '../../core/components/text/custom_text.dart';
import 'package:flutter/material.dart';

class UnAvailableView extends StatelessWidget {
  const UnAvailableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Ulaşılamıyor'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CustomText(
            'Üzgünüz bir şeyler yanlış gitti!. Şu an Geçerli Sayfaya Ulaşılamıyor',
            fontSize: 20,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
