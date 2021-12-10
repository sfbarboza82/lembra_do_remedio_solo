import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../notifications/notificacoes.dart';
import '../../database/repository.dart';
import '../../models/comprimido.dart';
import '../../screens/home/lista_medicamentos.dart';
import '../../screens/home/calendario.dart';
import '../../models/calendario_dia_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //flutter notificacoes
  final Notificacoes _notificacoes = Notificacoes();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  //lista de comprimidos database
  List<Comprimido> listaTodosComprimidos = List<Comprimido>();
  final Repository _repository = Repository();
  List<Comprimido> comprimidosDiarios = List<Comprimido>();

  //calendario dias
  final CalendarioDiaModel _dias = CalendarioDiaModel();
  List<CalendarioDiaModel> _listaDias;

  //handle escolha do ultimo dia index calendario
  int _ultimoDia = 0;

  @override
  void initState() {
    super.initState();
    initNotifies();
    setData();
    _listaDias = _dias.getCurrentDays();
  }

  //init notificacoes
  Future initNotifies() async => flutterLocalNotificationsPlugin = await _notificacoes.initNotifies(context);


  //get todos os dados database
  Future setData() async {
    listaTodosComprimidos.clear();
    (await _repository.getAllData("Comprimidos")).forEach((comprimidoMap) {
      listaTodosComprimidos.add(Comprimido().comprimidoMapToObject(comprimidoMap));
    });
    selecionarDia(_listaDias[_ultimoDia]);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    final Widget addButton = FloatingActionButton(
      elevation: 2.0,
      onPressed: () async {
        //refresh the pills from database
        await Navigator.pushNamed(context, "/add_medicamento")
            .then((_) => setData());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: 24.0,
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );

    return Scaffold(
      floatingActionButton: addButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 0.0, left: 25.0, right: 25.0, bottom: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: deviceHeight * 0.04,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: deviceHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Meus Remédios",
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Calendario(selecionarDia,_listaDias),
                ),
                SizedBox(height: deviceHeight * 0.03),
                comprimidosDiarios.isEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: WavyAnimatedTextKit(
                          textStyle: TextStyle(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          text: [
                            "Sem Remédios Hoje!"
                          ],
                          isRepeatingAnimation: true,
                          speed: Duration(milliseconds: 150),
                        ),
                      )
                    : ListaMedicamentos(comprimidosDiarios,setData,flutterLocalNotificationsPlugin)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //clique no dia do calendario

  void selecionarDia(CalendarioDiaModel diaSelecionado){
    setState(() {
      _ultimoDia = _listaDias.indexOf(diaSelecionado);
      _listaDias.forEach((dia) => dia.confirmado = false );
      CalendarioDiaModel selecionarDia = _listaDias[_listaDias.indexOf(diaSelecionado)];
      selecionarDia.confirmado = true;
      comprimidosDiarios.clear();
      listaTodosComprimidos.forEach((comprimido) {
        DateTime dataComprimido = DateTime.fromMicrosecondsSinceEpoch(comprimido.tempo * 1000);
        if(selecionarDia.numeroDia == dataComprimido.day && selecionarDia.mes == dataComprimido.month && selecionarDia.ano == dataComprimido.year){
          comprimidosDiarios.add(comprimido);
        }
      });
      comprimidosDiarios.sort((comprimido1,comprimido2) => comprimido1.tempo.compareTo(comprimido2.tempo));
    });
  }

}
