import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/domain/pergunta.dart';

import '../domain/static.dart';
import '../util/Utils.dart';
import 'TelaPersistenciaQuizz.dart';

class CadastroQuizPage extends StatefulWidget {
  const CadastroQuizPage({Key? key}) : super(key: key);

  @override
  State<CadastroQuizPage> createState() => _CadastroQuizPageState();
}

class _CadastroQuizPageState extends State<CadastroQuizPage> {
  String opcao = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: const Text("CadastroQuizPage"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _getListaBotoes(context),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[800],
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TelaPersistenciaQuizz()))
              .then((value) => setState(() {}));
        },
        tooltip: 'Nova Pergunta',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getListaBotoes(context) {
    List<botao> lista = [];

    for (int i = 0; i < perguntas.length; i++) {
      void _abrirModalOpcoes() {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: _getOpcoesQuestionario(perguntas[i]),
              );
            });
      }

      var novoBotao = botao(perguntas[i].tema, _abrirModalOpcoes, 80);
      lista.add(novoBotao);
    }

    return Column(children: lista);
  }

  List<botaoOpcao> _getOpcoesQuestionario(Pergunta p) {
    Function redirecionarTelaEdicao = () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TelaPersistenciaQuizz(pergunta: p)))
          .then((value) => setState(() {}));
    };

    List<botaoOpcao> opcoes = [
      botaoOpcao("Editar", redirecionarTelaEdicao),
      botaoOpcao("Excluir", null),
    ];

    return opcoes;
  }
}
