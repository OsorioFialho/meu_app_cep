import 'package:dio/dio.dart';
import 'package:meu_app_cep/model/cep_back4app_model.dart';

class CepBack4AppRepository {
  Future<CepBack4AppModel> obterCeps() async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "Lctkliq7FUC45JagzUJZBmsprCBiM5kAdYTu6r9s";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "uYo0cAvm6dO1diLhvFqusLsxq7l3XtQZQ9dr1rpO";
    dio.options.headers["Content-Type"] = "application/json";
    var result = await dio.get("https://parseapi.back4app.com/classes/Ceps");
    return CepBack4AppModel.fromJson(result.data);
  }

  Future<void> criarCeps(
      var cep, var logradouro, var bairro, var localidade) async {
    var verificaCeps = await obterCeps();
    var existeCeps = verificaCeps.ceps
        .where((existingCep) => existingCep.cep == cep)
        .toList();
    if (existeCeps.isEmpty) {
      var dio = Dio();
      dio.options.headers["X-Parse-Application-Id"] =
          "Lctkliq7FUC45JagzUJZBmsprCBiM5kAdYTu6r9s";
      dio.options.headers["X-Parse-REST-API-Key"] =
          "uYo0cAvm6dO1diLhvFqusLsxq7l3XtQZQ9dr1rpO";
      dio.options.headers["Content-Type"] = "application/json";

      Map<String, dynamic> data = {
        "logradouro": logradouro,
        "bairro": bairro,
        "localidade": localidade,
        "cep": cep
      };
      await dio.post("https://parseapi.back4app.com/classes/Ceps", data: data);
    } else {
      //print("CEP já existe");
    }
  }

  Future<void> deletarTodosCeps(String id) async {
    var dio = Dio();
    dio.options.headers["X-Parse-Application-Id"] =
        "Lctkliq7FUC45JagzUJZBmsprCBiM5kAdYTu6r9s";
    dio.options.headers["X-Parse-REST-API-Key"] =
        "uYo0cAvm6dO1diLhvFqusLsxq7l3XtQZQ9dr1rpO";
    dio.options.headers["Content-Type"] = "application/json";

    await dio.delete("https://parseapi.back4app.com/classes/Ceps/$id");
  }
}
