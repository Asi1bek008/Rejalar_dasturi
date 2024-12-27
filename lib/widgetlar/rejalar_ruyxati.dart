import 'package:flutter/material.dart';
import 'package:rejalar_dasturi/widgetlar/reja.dart';

import '../models/reja_modeli.dart';

class RejalarRuyxati extends StatelessWidget {
  List<RejaModeli> ruyxat;
  final Function _rejaniUchirish;

  final Function bajarilganDebBelgilash;
  RejalarRuyxati(this.ruyxat,this.bajarilganDebBelgilash,this._rejaniUchirish, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: ruyxat.length,
        itemBuilder: (ctx, index) {
          return Reja(ruyxat[index],bajarilganDebBelgilash,_rejaniUchirish);
        },
      ),
    );
  }
}
