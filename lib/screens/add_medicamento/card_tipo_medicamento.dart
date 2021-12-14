import 'package:flutter/material.dart';
import 'package:lembra_do_remedio/models/tipo_medicamento.dart';

class CardTipoMedicamento extends StatelessWidget {
  final TipoMedicamento tipoMedicamento;
  final Function handler;
  CardTipoMedicamento(this.tipoMedicamento, this.handler);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => handler(tipoMedicamento),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: tipoMedicamento.selecionado
                  ? Color.fromRGBO(7, 190, 200, 1)
                  : Colors.white,
            ),
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5.0,
                ),
                Container(width: 50, height: 50.0, child: tipoMedicamento.image),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                    child: Text(
                  tipoMedicamento.nome,
                  style: TextStyle(
                      color: tipoMedicamento.selecionado
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w500),
                )),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 15.0,
        )
      ],
    );
  }
}
