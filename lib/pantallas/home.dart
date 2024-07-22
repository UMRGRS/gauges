import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rtdata/pantallas/GHume.dart';
import 'package:rtdata/pantallas/GTemp.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AfterLayoutMixin<Home> {
  double humidity = 0, temperature = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Gauge"),
          actions: [
            IconButton(
                onPressed: () async{
                  _showMyDialog();
                  await getData();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: GTemp(
              temp: temperature,
            )),
            const Divider(
              height: 5,
            ),
            Expanded(
              child: GHume(
                humidity: humidity,
              ),
            ),
            const Divider(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  setTempMessage(),
                  const SizedBox(
                    height: 8,
                  ),
                  setHumMessage(),
                ],
              ),
            )
          ],
        ));
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    _showMyDialog();
    await getData();
    Navigator.of(context).pop();
    Timer.periodic(
      //Change timer
      const Duration(seconds: 30),
      (timer) async {
        await getData();
      },
    );
  }

  Future<void> getData() async {
    final ref = FirebaseDatabase.instance.ref();
    final temp = await ref.child("Living Room/temperature/value").get();
    final humi = await ref.child("Living Room/humidity/value").get();
    if (temp.exists && humi.exists) {
      temperature = double.parse(temp.value.toString());
      humidity = double.parse(humi.value.toString());
    } else {
      temperature = -1;
      humidity = -1;
    }
    setState(() {});
  }

  Widget setTempMessage() {
    Color? color;
    IconData? icon;
    String msg = '';
    if (temperature <= 0) {
      color = Colors.blue;
      icon = Icons.ac_unit;
      msg = 'Hace frio';
    } else if (temperature > 0 && temperature <= 30) {
      color = Colors.green;
      icon = Icons.sunny;
      msg = 'La temperatura es agradable';
    } else if (temperature > 30) {
      color = Colors.red;
      icon = Icons.local_fire_department_rounded;
      msg = 'La temperatura es muy alta';
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          msg,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  Widget setHumMessage() {
    Color? color;
    IconData? icon;
    String msg = '';
    if (humidity <= 0) {
      color = Colors.brown;
      icon = Icons.whatshot;
      msg = 'El tiempo es seco';
    } else if (humidity > 0 && humidity <= 50) {
      color = Colors.amber;
      icon = Icons.water_drop_outlined;
      msg = 'Humedad media';
    } else if (humidity > 50) {
      color = Colors.purple;
      icon = Icons.flood;
      msg = 'Humedad alta';
    }
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(children: [
        Icon(icon),
        const SizedBox(
          width: 5,
        ),
        Text(
          msg,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ]),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Cargando...'),
          content: CircularProgressIndicator(),
        );
      },
    );
  }
}
