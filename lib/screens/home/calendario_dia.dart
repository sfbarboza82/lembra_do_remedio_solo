import "package:flutter/material.dart";
import '../../models/calendario_dia_model.dart';

class CalendarioDia extends StatefulWidget {
  final CalendarioDiaModel dia;
  final Function cliqueDia;

  CalendarioDia(this.dia, this.cliqueDia);

  @override
  _CalendarioDiaState createState() => _CalendarioDiaState();
}

class _CalendarioDiaState extends State<CalendarioDia> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.dia.diario,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: constrains.maxHeight * 0.1,
          ),
          GestureDetector(
            onTap: () => widget.cliqueDia(widget.dia),
            child: CircleAvatar(
              radius: constrains.maxHeight * 0.25,
              backgroundColor: widget.dia.confirmado
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  widget.dia.numeroDia.toString(),
                  style: TextStyle(
                      color:
                          widget.dia.confirmado ? Colors.white : Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
