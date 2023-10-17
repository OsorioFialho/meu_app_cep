import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meu_app_cep/model/viacep_model.dart';

class ViaCepRepository {
  Future<ViaCEPModel> consultarCEP(String cep) async {
    final url = Uri.parse("https://viacep.com.br/ws/$cep/json/");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViaCEPModel.fromJson(json);
    } else {
      return ViaCEPModel();
    }
  }
}
