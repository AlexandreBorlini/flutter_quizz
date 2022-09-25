import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../TelaCriacaoQuizz.dart';
import '../TelaEdicaoQuizz.dart';
import '../Utils.dart';
import '../mock.dart';

class CadastroQuizPage extends StatefulWidget {
  const CadastroQuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

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
        title: Text(widget.title),
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
              .push(MaterialPageRoute(builder: (context) => TelaCriacao()))
              .then((value) => setState(() {}));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getListaBotoes(context) {
    List<botao> lista = [];

    for (int i = 0; i < questionarios.length; i++) {
      void _abrirModalOpcoes() {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: _getOpcoesQuestionario(questionarios[i]),
              );
            });
      }

      var novoBotao = botao(questionarios[i].nome, _abrirModalOpcoes, 80);
      lista.add(novoBotao);
    }

    return Column(children: lista);
  }

  List<botaoOpcao> _getOpcoesQuestionario(Questionario q) {
    Function redirecionarTelaEdicao = () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => TelaEdicao(q)))
          .then((value) => setState(() {}));
    };

    List<botaoOpcao> opcoes = [
      botaoOpcao("Editar", redirecionarTelaEdicao),
      botaoOpcao("Excluir", null),
    ];

    return opcoes;
  }
}
