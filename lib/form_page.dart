import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNIK = TextEditingController();
  TextEditingController controllerAlamat = TextEditingController();
  TextEditingController controllerNoHP = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String valueJK = "Pilih Jenis Kelamin";
  List listJK = ["Laki-laki", "Perempuan"];
  DateTime defaultDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form Entry")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "NIK tidak boleh kosong";
                  }
                },
                controller: controllerNIK,
                decoration: const InputDecoration(
                    labelText: "NIK",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Masukan NIK",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama tidak boleh kosong";
                  }
                },
                controller: controllerNama,
                decoration: const InputDecoration(
                    labelText: "Nama Lengkap",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Masukan Nama Lengkap",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "No. Handphone tidak boleh kosong";
                  }
                },
                controller: controllerNoHP,
                decoration: const InputDecoration(
                    labelText: "No. Handphone",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Masukan No.Handphone",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Jenis Kelamin",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                isExpanded: true,
                hint: Text(valueJK),
                validator: (value) {
                  if (valueJK == "Pilih Jenis Kelamin") {
                    return 'Jenis Kelamin tidak boleh kosong';
                  }
                },
                elevation: 0,
                borderRadius: BorderRadius.circular(12),
                onChanged: (value) {
                  setState(() {
                    valueJK = value!;
                  });
                },
                items: listJK
                    .map<DropdownMenuItem<String>>(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value == "Tanggal Lahir") {
                    return "Tanggal Lahir tidak boleh kosong";
                  }
                },
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: defaultDate,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  print("pickedDate: $pickedDate");
                  setState(() {
                    defaultDate = pickedDate!;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Tanggal Lahir",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: DateFormat("d-M-y").format(defaultDate),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alamat tidak boleh kosong";
                  }
                },
                controller: controllerAlamat,
                decoration: const InputDecoration(
                    labelText: "Alamat",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Masukan Alamat",
                    border: OutlineInputBorder()),
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () async {
                    String googleURL =
                        "https://www.google.com/maps/search/?api=1&query=${controllerAlamat.text}";
                    await canLaunchUrlString(googleURL)
                        ? await launchUrlString(googleURL)
                        : throw "Could not launch URL";

                    // final Uri url = Uri.parse(
                    //     "https://www.google.com/maps/search/?api=1&query=$lat,$long");
                    // if (!await launchUrl(url,
                    //     mode: LaunchMode.externalApplication)) {
                    //   throw "Could not launch $url";
                    // }
                  },
                  child: const Text("Check Alamat")),
              const SizedBox(
                height: 15.0,
              ),
              // TextFormField(
              //   readOnly: true,
              //   decoration: const InputDecoration(
              //       hintText: "Gambar", border: OutlineInputBorder()),
              // ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool confirm = false;
                      await showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('NIK = ${controllerNIK.text}'),
                                  Text('Nama = ${controllerNama.text}'),
                                  Text('No. HP = ${controllerNoHP.text}'),
                                  Text('Jenis Kelamin = ${valueJK}'),
                                  Text(
                                      'Tanggal = ${DateFormat("d-M-y").format(defaultDate)}'),
                                  Text('Alamat = ${controllerAlamat.text}'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[600],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  confirm = true;
                                  Navigator.pop(context);
                                  FirebaseFirestore.instance
                                      .runTransaction((transaction) async {
                                    CollectionReference reference =
                                        FirebaseFirestore.instance
                                            .collection("formEntry");
                                    await reference
                                        .doc(
                                            "${DateTime.now().millisecondsSinceEpoch.toString()}+${controllerNIK.text}")
                                        .set({
                                      "nik": controllerNIK.text,
                                      "nama": controllerNama.text,
                                      "nohp": controllerNoHP.text,
                                      "jenisKelamin": valueJK,
                                      "date": DateFormat("d-M-y")
                                          .format(defaultDate),
                                      "alamat": controllerAlamat.text,
                                      "urlGamber": "kosong",
                                      "namaGambar": "kosong",
                                      "createTime":
                                          DateTime.now().millisecondsSinceEpoch
                                    });
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Sukses")));
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }
}
