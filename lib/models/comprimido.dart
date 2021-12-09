class Comprimido {
  int id;
  String nome;
  String quantidade;
  String tipo;
  int semanas;
  String formMedicamento;
  int tempo;
  int idNotificacao;

  Comprimido(
      {this.id,
      this.semanas,
      this.tempo,
      this.quantidade,
      this.formMedicamento,
      this.nome,
      this.tipo,
      this.idNotificacao});

  //set comprimido no map

  Map<String, dynamic> comprimidoToMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['nome'] = this.nome;
    map['quantidade'] = this.quantidade;
    map['tipo'] = this.tipo;
    map['semanas'] = this.semanas;
    map['formMedicamento'] = this.formMedicamento;
    map['tempo'] = this.tempo;
    map['idNotificacao'] = this.idNotificacao;
    return map;
  }

  //criar objeto comprimido no map
  Comprimido comprimidoMapToObject(Map<String, dynamic> comprimidoMap) {
    return Comprimido(
        id: comprimidoMap['id'],
        nome: comprimidoMap['nome'],
        quantidade: comprimidoMap['quantidade'],
        tipo: comprimidoMap['tipo'],
        semanas: comprimidoMap['semanas'],
        formMedicamento: comprimidoMap['formMedicamento'],
        tempo: comprimidoMap['tempo'],
        idNotificacao: comprimidoMap['idNotificacao']);
  }

  //get imagem
  String get image{
    switch(this.formMedicamento){
      case "Xarope": return "assets/images/xarope.png"; break;
      case "Comprimidos":return "assets/images/comprimidos.png"; break;
      case "Capsulas":return "assets/images/capsulas.png"; break;
      case "Pomada":return "assets/images/pomada.png"; break;
      case "Gotas":return "assets/images/gotas.png"; break;
      case "Seringa":return "assets/images/seringa.png"; break;
      default : return "assets/images/comprimidos.png"; break;
    }
  }

}
