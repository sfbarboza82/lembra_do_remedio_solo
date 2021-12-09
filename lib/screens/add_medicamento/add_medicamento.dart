import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:lembra_do_remedio/database/repository.dart';
import 'package:lembra_do_remedio/helpers/snack_bar.dart';
import 'package:lembra_do_remedio/models/comprimido.dart';
import 'package:lembra_do_remedio/models/tipo_medicamento.dart';
import 'package:lembra_do_remedio/notifications/notificacoes.dart';
import '../../helpers/platform_flat_button.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'card_tipo_medicamento.dart';
import 'form_fields.dart';

class AddMedicamento extends StatefulWidget {
  @override
  _AddMedicamentoState createState() => _AddMedicamentoState();
}

class _AddMedicamentoState extends State<AddMedicamento> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();

  //tipos medicamentos
  final List<String> weightValues = ["comp", "ml", "mg"];

  //lista de medicamentos objeto
  final List<TipoMedicamento> tiposMedicamento = [
    TipoMedicamento("Xarope", Image.asset("assets/images/xarope.png"), true),
    TipoMedicamento(
        "Comprimidos", Image.asset("assets/images/comprimidos.png"), false),
    TipoMedicamento(
        "Capsulas", Image.asset("assets/images/capsulas.png"), false),
    TipoMedicamento(
        "Pomada", Image.asset("assets/images/pomada.png"), false),
    TipoMedicamento(
        "Gotas", Image.asset("assets/images/gotas.png"), false),
    TipoMedicamento(
        "Seringa", Image.asset("assets/images/seringa.png"), false),
  ];

  //objeto comprimido
  int semanas = 1;
  String selectWeight;
  DateTime setDate = DateTime.now();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController quantidadeController = TextEditingController();

  //database e notificacoes
  final Repository _repository = Repository();
  final Notificacoes _notificacoes = Notificacoes();

  @override
  void initState() {
    super.initState();
    selectWeight = weightValues[0];
    initNotifies();
  }

  //init notificacoes
  Future initNotifies() async => flutterLocalNotificationsPlugin =
      await _notificacoes.initNotifies(context);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 30.0, bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: deviceHeight * 0.05,
                child: FittedBox(
                  child: InkWell(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(left: 15.0),
                height: deviceHeight * 0.05,
                child: FittedBox(
                    child: Text(
                  "Adicionar Remédio",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.black),
                )),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Container(
                height: deviceHeight * 0.37,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: FormFields(
                        semanas,
                        selectWeight,
                        popUpMenuItemChanged,
                        sliderChanged,
                        nomeController,
                        quantidadeController)),
              ),
              Container(
                height: deviceHeight * 0.035,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: FittedBox(
                    child: Text(
                      "Medicamentos",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.02,
              ),
              Container(
                height: 100,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ...tiposMedicamento.map(
                        (tipo) => CardTipoMedicamento(tipo, cliqueTipoMedicamento))
                  ],
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              Container(
                width: double.infinity,
                height: deviceHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openTimePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat.Hm().format(this.setDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.access_time,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        child: PlatformFlatButton(
                          handler: () => openDatePicker(),
                          buttonChild: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                DateFormat("dd.MM").format(this.setDate),
                                style: TextStyle(
                                    fontSize: 32.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.event,
                                size: 30,
                                color: Theme.of(context).primaryColor,
                              )
                            ],
                          ),
                          color: Color.fromRGBO(7, 190, 200, 0.1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: deviceHeight * 0.09,
                width: double.infinity,
                child: PlatformFlatButton(
                  handler: () async => salvar(),
                  color: Theme.of(context).primaryColor,
                  buttonChild: Text(
                    "Pronto",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //slider changer
  void sliderChanged(double value) =>
      setState(() => this.semanas = value.round());

  //choose popum menu item
  void popUpMenuItemChanged(String value) =>
      setState(() => this.selectWeight = value);

  //mostrar
  //selecionar tempo

  Future<void> openTimePicker() async {
    await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            helpText: "Horário")
        .then((value) {
      DateTime newDate = DateTime(
          setDate.year,
          setDate.month,
          setDate.day,
          value != null ? value.hour : setDate.hour,
          value != null ? value.minute : setDate.minute);
      setState(() => setDate = newDate);
      print(newDate.hour);
      print(newDate.minute);
    });
  }

  //mostrar data e mudanca de data
  Future<void> openDatePicker() async {
    await showDatePicker(
            context: context,
            initialDate: setDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 100000)))
        .then((value) {
      DateTime newDate = DateTime(
          value != null ? value.year : setDate.year,
          value != null ? value.month : setDate.month,
          value != null ? value.day : setDate.day,
          setDate.hour,
          setDate.minute);
      setState(() => setDate = newDate);
      print(setDate.day);
      print(setDate.month);
      print(setDate.year);
    });
  }

  //salvar comprimido database
  Future salvar() async {
    //check if medicine time is lower than actual time
    if (setDate.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch) {
      snackbar.showSnack(
          "Verifique a data e a hora do seu remédio", _scaffoldKey, null);
    } else {
      //criar objeto comprimido
      Comprimido comprimido = Comprimido(
          quantidade: quantidadeController.text,
          semanas: semanas,
          formMedicamento: tiposMedicamento[tiposMedicamento.indexWhere((element) => element.selecionado == true)].nome,
          nome: nomeController.text,
          tempo: setDate.millisecondsSinceEpoch,
          tipo: selectWeight,
          idNotificacao: Random().nextInt(10000000));

      //salvar varios medicamentos e verificacoes
      for (int i = 0; i < semanas; i++) {
        dynamic result =
            await _repository.insertData("Comprimidos", comprimido.comprimidoToMap());
        if (result == null) {
          snackbar.showSnack("Algo está errado", _scaffoldKey, null);
          return;
        } else {
          //set notificacao schneudele
          tz.initializeTimeZones();
          tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));
          await _notificacoes.showNotification(comprimido.nome, comprimido.quantidade + " " + comprimido.formMedicamento + " " + comprimido.tipo, tempo,
              comprimido.idNotificacao,
              flutterLocalNotificationsPlugin);
          setDate = setDate.add(Duration(milliseconds: 604800000));
          comprimido.tempo = setDate.millisecondsSinceEpoch;
          comprimido.idNotificacao = Random().nextInt(10000000);
        }
      }

      snackbar.showSnack("Salvo", _scaffoldKey, null);
      Navigator.pop(context);
    }
  }

  //clique form medicamento
  void cliqueTipoMedicamento(TipoMedicamento medicamento) {
    setState(() {
      tiposMedicamento.forEach((tipoMedicamento) => tipoMedicamento.selecionado = false);
      tiposMedicamento[tiposMedicamento.indexOf(medicamento)].selecionado = true;
    });
  }

  //get diferenca tempo
  int get tempo =>
      setDate.millisecondsSinceEpoch -
      tz.TZDateTime.now(tz.local).millisecondsSinceEpoch;
}
