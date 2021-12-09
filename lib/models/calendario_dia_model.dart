import 'package:intl/intl.dart';

class CalendarioDiaModel {
  String diario;
  int numeroDia;
  int mes;
  int ano;
  bool confirmado;

  CalendarioDiaModel(
      {this.diario, this.numeroDia, this.ano, this.mes, this.confirmado});

  //get dia atual 7 dias
  List<CalendarioDiaModel> getCurrentDays() {
    final List<CalendarioDiaModel> listaDias = List();
    DateTime currentTime = DateTime.now();
    for (int i = 0; i < 7; i++) {
      listaDias.add(CalendarioDiaModel(
          diario: DateFormat.E('pt_Br').format(currentTime).toString()[0],
          numeroDia: currentTime.day,
          mes: currentTime.month,
          ano: currentTime.year,
          confirmado: false));
      currentTime = currentTime.add(Duration(days: 1));
    }
    listaDias[0].confirmado = true;
    return listaDias;
  }
}
