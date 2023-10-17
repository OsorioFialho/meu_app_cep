import 'package:flutter/material.dart';
import 'package:meu_app_cep/model/cep_back4app_model.dart';
import 'package:meu_app_cep/back4app/cep_back4app_repository.dart';

class HistoricoCEP extends StatefulWidget {
  const HistoricoCEP({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoricoCEPState createState() => _HistoricoCEPState();
}

class _HistoricoCEPState extends State<HistoricoCEP> {
  final CepBack4AppRepository _repository = CepBack4AppRepository();

  Future<CepBack4AppModel> _obterCepsFuture() {
    return _repository.obterCeps();
  }

  void _deletarCep(String objectId) async {
    await _repository.deletarTodosCeps(objectId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de CEPs'),
      ),
      body: FutureBuilder<CepBack4AppModel>(
        future: _obterCepsFuture(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.ceps.isEmpty) {
            return const Center(child: Text('Nenhum dado encontrado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.ceps.length,
              itemBuilder: (context, index) {
                final item = snapshot.data!.ceps[index];
                return ListTile(
                  title: Text('Cep: ${item.cep}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Logradouro: ${item.logradouro}'),
                      Text('Bairro: ${item.bairro}'),
                      Text('Localidade: ${item.localidade}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deletarCep(item.objectId);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
