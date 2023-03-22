import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HasilPage extends StatefulWidget {
  const HasilPage({super.key});

  @override
  State<HasilPage> createState() => _HasilPageState();
}

class _HasilPageState extends State<HasilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lihat Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('formEntry').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HasilFormEntry(
                listHasilFormEntry: snapshot.data!.docs,
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class HasilFormEntry extends StatefulWidget {
  const HasilFormEntry({super.key, required this.listHasilFormEntry});
  final List<DocumentSnapshot> listHasilFormEntry;

  @override
  State<HasilFormEntry> createState() => _HasilFormEntryState();
}

class _HasilFormEntryState extends State<HasilFormEntry> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listHasilFormEntry.length,
      itemBuilder: (context, index) {
        final itemsList = widget.listHasilFormEntry[index];
        String storageNIK = itemsList["nik"];
        String storageNama = itemsList["nama"];
        String storageNoHP = itemsList["nohp"];
        String storageJenisKelamin = itemsList["jenisKelamin"];
        String storageTanggal = itemsList["date"];
        String storageAlamat = itemsList["alamat"];
        // String storageNamaGambar = itemsList["namaGambar"];
        // String storageUrlGambar = itemsList["urlGambar"];
        // String storageCreateAt = itemsList["createTime"];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Expanded(flex: 1, child: Text("NIK")),
              Expanded(flex: 3, child: Text(": $storageNIK"))
            ]),
            Row(children: [
              const Expanded(flex: 1, child: Text("Nama")),
              Expanded(flex: 3, child: Text(": $storageNama"))
            ]),
            Row(children: [
              const Expanded(flex: 1, child: Text("No. Handphone")),
              Expanded(flex: 3, child: Text(": $storageNoHP"))
            ]),
            Row(children: [
              const Expanded(flex: 1, child: Text("Jenis Kelamin")),
              Expanded(flex: 3, child: Text(": $storageJenisKelamin"))
            ]),
            Row(children: [
              const Expanded(flex: 1, child: Text("Alamat")),
              Expanded(flex: 3, child: Text(": $storageAlamat"))
            ]),
            Row(children: [
              const Expanded(flex: 1, child: Text("Tanggal")),
              Expanded(flex: 3, child: Text(": $storageTanggal"))
            ]),
            const SizedBox(
              height: 10.0,
            ),
            Divider(
              color: Colors.black,
            )
          ],
        );
      },
    );
  }
}
