import 'package:flutter/material.dart';
import 'package:meu_app_cep/back4app/cep_back4app_repository.dart';
import 'package:meu_app_cep/pages/cep_http_page.dart';
import 'package:meu_app_cep/repository/via_cep_repository.dart';
import 'package:meu_app_cep/model/viacep_model.dart';

class ConsultaCEP extends StatefulWidget {
  const ConsultaCEP({Key? key}) : super(key: key);

  @override
  State<ConsultaCEP> createState() => _ConsultaCEPState();
}

class _ConsultaCEPState extends State<ConsultaCEP> {
  List<List<String>> historicoCEP = [];
  var cepController = TextEditingController(text: "");
  bool loading = false;
  ViaCEPModel viacepModel = ViaCEPModel();
  var viaCEPRepository = ViaCepRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            const Text(
              "Consulta de CEP",
              style: TextStyle(fontSize: 22),
            ),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              //maxLength: 8,
              onChanged: (String value) async {
                final CepBack4AppRepository repository =
                    CepBack4AppRepository();
                var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                if (cep.length == 8) {
                  setState(() {
                    loading = true;
                  });
                  viacepModel = (await viaCEPRepository.consultarCEP(cep));
                  if (viacepModel.cep != null) {
                    await repository.criarCeps(
                        viacepModel.cep,
                        viacepModel.logradouro,
                        viacepModel.bairro,
                        viacepModel.localidade);
                  }
                }
                setState(() {
                  loading = false;
                });
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              viacepModel.logradouro ?? "Digite um CEP válido",
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              viacepModel.bairro ?? "",
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
              style: const TextStyle(fontSize: 22),
            ),
            if (loading) const CircularProgressIndicator()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.history),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoricoCEP()),
          );
        },
      ),
    ));
  }
}
