import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/domain/pergunta.dart';

import '../controllers/controle_persistencia_perguntas.dart';
import '../util/Utils.dart';
import 'TelaPersistenciaQuizz.dart';

class CadastroQuizPage extends StatefulWidget {
  const CadastroQuizPage({Key? key}) : super(key: key);

  @override
  State<CadastroQuizPage> createState() => _CadastroQuizPageState();
}

class _CadastroQuizPageState extends State<CadastroQuizPage> {
  String opcao = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  late ControlePersistenciaPerguntas _controlePersistenciaPerguntas;

  @override
  void initState() {
    super.initState();
    _controlePersistenciaPerguntas =
        ControlePersistenciaPerguntas(auth.currentUser!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
        title: const Text("CadastroQuizPage"),
      ),
      body: _stream_builder_perguntas(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[800],
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => TelaPersistenciaQuizz()))
              .then((value) => setState(() {}));
        },
        tooltip: 'Nova Pergunta',
        child: const Icon(Icons.add),
      ),
    );
  }

  Container _stream_builder_perguntas() {
    return Container(
        padding: EdgeInsets.all(18),
        child: StreamBuilder<QuerySnapshot>(
            stream: _controlePersistenciaPerguntas.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              _controlePersistenciaPerguntas.recuperarPerguntas(snapshot.data!);
              return _single_child_scroll_bar();
            }));
  }

  SingleChildScrollView _single_child_scroll_bar() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _getListaBotoes(context),
          ],
        ),
      ),
    );
  }

  Widget _getListaBotoes(context) {
    List<botao> lista = [];

    var perguntas = _controlePersistenciaPerguntas.perguntas;

    for (int i = 0; i < perguntas!.length; i++) {
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
          .push(MaterialPageRoute(
              builder: (context) => TelaPersistenciaQuizz(pergunta: p)));
    };

    Function chamaDelecao = () {
      _controlePersistenciaPerguntas.delete(context, p);
      setState(() {
        Navigator.pop(context);
      });
    };

    List<botaoOpcao> opcoes = [
      botaoOpcao("Editar", redirecionarTelaEdicao),
      botaoOpcao("Excluir", chamaDelecao),
    ];

    return opcoes;
  }
}
