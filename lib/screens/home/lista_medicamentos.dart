import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lembra_do_remedio/models/medicamento.dart';
import '../../screens/home/card_medicamento.dart';

class ListaMedicamentos extends StatelessWidget {
  final List<Medicamento> listaMedicamentos;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  ListaMedicamentos(this.listaMedicamentos, this.setData,
      this.flutterLocalNotificationsPlugin);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => CardMedicamento(
          listaMedicamentos[index], setData, flutterLocalNotificationsPlugin),
      itemCount: listaMedicamentos.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
