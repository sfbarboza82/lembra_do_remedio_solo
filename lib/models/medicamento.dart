class Medicamento {
  int id;
  String nome;
  String quantidade;
  String tipo;
  int diasRecorrentes;
  String formMedicamento;
  int tempo;
  int idNotificacao;

  Medicamento(
      {this.id,
      this.diasRecorrentes,
      this.tempo,
      this.quantidade,
      this.formMedicamento,
      this.nome,
      this.tipo,
      this.idNotificacao});

  //set medicamento no map

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map['id'] = this.id;
    map['nome'] = this.nome;
    map['quantidade'] = this.quantidade;
    map['tipo'] = this.tipo;
    map['diasRecorrentes'] = this.diasRecorrentes;
    map['formMedicamento'] = this.formMedicamento;
    map['tempo'] = this.tempo;
    map['idNotificacao'] = this.idNotificacao;
    return map;
  }

  //criar objeto medicamento no map
  Medicamento mapToObject(Map<String, dynamic> Map) {
    return Medicamento(
        id: Map['id'],
        nome: Map['nome'],
        quantidade: Map['quantidade'],
        tipo: Map['tipo'],
        diasRecorrentes: Map['diasRecorrentes'],
        formMedicamento: Map['formMedicamento'],
        tempo: Map['tempo'],
        idNotificacao: Map['idNotificacao']);
  }

  //get imagem
  String get image {
    switch (this.formMedicamento) {
      case "Xarope":
        return "assets/images/xarope.png";
        break;
      case "Comprimidos":
        return "assets/images/comprimidos.png";
        break;
      case "Capsulas":
        return "assets/images/capsulas.png";
        break;
      case "Pomada":
        return "assets/images/pomada.png";
        break;
      case "Gotas":
        return "assets/images/gotas.png";
        break;
      case "Seringa":
        return "assets/images/seringa.png";
        break;
      default:
        return "assets/images/comprimidos.png";
        break;
    }
  }
}
