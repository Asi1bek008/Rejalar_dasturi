import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RajalarSanasi extends StatelessWidget {
  final Function sananiTanlash;
  final DateTime belgilanganSana;
  final Function oldingiSana;
  final Function keyingiSana;

  const RajalarSanasi(
      this.sananiTanlash,
      this.belgilanganSana,
      this.keyingiSana,
      this.oldingiSana, {super.key}
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              oldingiSana();
            },
            icon: const Icon(
              Icons.arrow_left,
              size: 45,
            )),
        TextButton(
          onPressed: () {
            sananiTanlash();
          },
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "${DateFormat.EEEE().format(belgilanganSana)}, ",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
              TextSpan(
                text: DateFormat("d MMM").format(belgilanganSana),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ]),
          ),
        ),
        IconButton(
            onPressed: () {
              keyingiSana();
            },
            icon: const Icon(
              Icons.arrow_right,
              size: 45,
            ))
      ],
    );
  }

}
