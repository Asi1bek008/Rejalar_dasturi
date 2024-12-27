import 'package:flutter/material.dart';
import 'package:rejalar_dasturi/servise/shared_perference.dart';
import 'package:rejalar_dasturi/widgetlar/rejalar_malumoti.dart';
import 'package:rejalar_dasturi/widgetlar/rejalar_ruyxati.dart';
import 'package:rejalar_dasturi/widgetlar/rejalar_sanasi.dart';
import 'package:rejalar_dasturi/widgetlar/yangi_reja.dart';

import 'models/reja_modeli.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime belgilanganSana = DateTime.now();

  var ruyxat = Rejalar();


  void sananiTanlash() {
    showDatePicker(
        context: context,
        firstDate: DateTime(2024),
        lastDate: DateTime(2040),
        initialDate: DateTime.now())
        .then((sana) {
      setState(() {
        belgilanganSana = sana!;
      });
    });
  }

  void oldingiSana() {
    setState(() {
      belgilanganSana = DateTime(
          belgilanganSana.year, belgilanganSana.month, belgilanganSana.day + 1);
    });
  }

  void keyingiSana() {
    setState(() {
      belgilanganSana = DateTime(
          belgilanganSana.year, belgilanganSana.month, belgilanganSana.day - 1);
    });
  }

  void yangiRejaQushish() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return YangiReja(rejaQushish);
        });
  }

  void rejaQushish(String name,DateTime kun){
    setState(() {
      ruyxat.addReja(name, kun);
    });
  }

  int get _bajarilganRejalar{
    return ruyxat.KunBuyichaReja(belgilanganSana).where((reja) => reja.bajarildi).length;
  }

  void bajarilganDebBelgilash(String rejaid){
    setState(() {
      ruyxat.KunBuyichaReja(belgilanganSana).firstWhere((reja) => reja.id == rejaid).bajarilganReja();
    });
  }

  void _rejaniUchirish(String rejaId) {
    setState(() {
      ruyxat.rejalar.removeWhere((reja) => reja.id == rejaId);
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    SharedPerference.storeName('Abror');
    SharedPerference.loadName().then((value)=>{
      print(value.toString())
    });
    SharedPerference.removeName().then((value)=>{
      print(value),
    });
    RejaModeli2 model1 =
    RejaModeli2(name: "Bozorga Borish", kuni: "DateTime.now()", id: "id1");
    SharedPerference.storeReja(model1);
    SharedPerference.loadReja().then((value) => {
      print(value?.toJson().toString()),
    });
    SharedPerference.removeReja().then((value) => {
      print(value)
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rejalar Dasturi",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Column(
        children: [
          RajalarSanasi(
            sananiTanlash,
            belgilanganSana,
            oldingiSana,
            keyingiSana,
          ),
          RejalarMalumoti(ruyxat.KunBuyichaReja(belgilanganSana),_bajarilganRejalar),
          RejalarRuyxati(ruyxat.KunBuyichaReja(belgilanganSana),bajarilganDebBelgilash,_rejaniUchirish),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          yangiRejaQushish();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
