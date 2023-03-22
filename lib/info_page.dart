import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informasi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama : PRAYOGI DWI CAHYO PUTRO"),
            Text("EMAIL : prayogidwicahyoputra@gmail.com"),
          ],
        ),
      ),
    );
  }
}
