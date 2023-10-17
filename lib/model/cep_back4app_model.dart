class CepBack4AppModel {
  List<Cep> ceps = [];

  CepBack4AppModel(this.ceps);

  CepBack4AppModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      ceps = <Cep>[];
      json['results'].forEach((v) {
        ceps.add(Cep.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = ceps.map((v) => v.toJson()).toList();
    return data;
  }
}

class Cep {
  String objectId = "";
  String logradouro = "";
  String bairro = "";
  String localidade = "";
  String createdAt = "";
  String updatedAt = "";
  String cep = "";

  Cep(this.objectId, this.logradouro, this.bairro, this.localidade,
      this.createdAt, this.updatedAt, this.cep);

  Cep.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cep = json['cep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['cep'] = cep;
    return data;
  }
}
