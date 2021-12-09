import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lembra_do_remedio/database/repository.dart';
import 'package:lembra_do_remedio/models/comprimido.dart';
import 'package:lembra_do_remedio/notifications/notificacoes.dart';

class CardMedicamento extends StatelessWidget {

  final Comprimido medicamento;
  final Function setData;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  CardMedicamento(this.medicamento,this.setData,this.flutterLocalNotificationsPlugin);

  @override
  Widget build(BuildContext context) {
    //verifica se o tempo do medicamento esta abaixo do atual
    final bool isEnd = DateTime.now().millisecondsSinceEpoch > medicamento.tempo;

    return Card(
        elevation: 0.0,
        margin: EdgeInsets.symmetric(vertical: 7.0),
        color: Colors.white,
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onLongPress: () =>
                _showDeleteDialog(context, medicamento.nome, medicamento.id, medicamento.idNotificacao),
            contentPadding:
                EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            title: Text(
              medicamento.nome,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Colors.black,
                  fontSize: 20.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "${medicamento.quantidade} ${medicamento.formMedicamento}",
              style: Theme.of(context).textTheme.headline5.copyWith(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                  decoration: isEnd ? TextDecoration.lineThrough : null),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  DateFormat("HH:mm").format(
                      DateTime.fromMillisecondsSinceEpoch(medicamento.tempo)),
                  style: TextStyle(
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      decoration: isEnd ? TextDecoration.lineThrough : null),
                ),
              ],
            ),
            leading: Container(
              width: 60.0,
              height: 60.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        isEnd ? Colors.white : Colors.transparent,
                        BlendMode.saturation),
                    child: Image.asset(
                      medicamento.image
                    )),
              ),
            )));
  }


  //mostrar dialogo de delete

  void _showDeleteDialog(BuildContext context, String nomeMedicamento, int idMedicamento, int idNotificacao) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Apagar ?"),
              content: Text("Você tem certeza que deseja apagar o $nomeMedicamento remédio?"),
              contentTextStyle:
                  TextStyle(fontSize: 17.0, color: Colors.grey[800]),
              actions: [
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text(
                    "Cancelar",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  splashColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  child: Text("Apagar",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () async {
                    await Repository().deleteData('Comprimidos', idMedicamento);
                    await Notificacoes().removeNotify(idNotificacao, flutterLocalNotificationsPlugin);
                    setData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

}
