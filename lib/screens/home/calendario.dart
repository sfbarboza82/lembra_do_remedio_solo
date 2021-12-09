import 'package:flutter/material.dart';
import '../../models/calendario_dia_model.dart';
import '../../screens/home/calendario_dia.dart';

class Calendario extends StatefulWidget {
  final Function selecionarDia;
  final List<CalendarioDiaModel> _listaDias;
  Calendario(this.selecionarDia,this._listaDias);
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      height: deviceHeight * 0.11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [...widget._listaDias.map((dia) => CalendarioDia(dia, widget.selecionarDia))],
      ),
    );
  }

}
