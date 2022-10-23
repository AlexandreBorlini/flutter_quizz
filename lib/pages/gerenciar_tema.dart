import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/domain/pergunta.dart';
import 'package:quiz/domain/tema.dart';
import 'package:quiz/pages/TelaPersistenciaQuizz.dart';
import 'package:quiz/util/Utils.dart';

import '../controllers/controle_persistencia_perguntas.dart';

class TelaGerenciarTema extends StatefulWidget {
  const TelaGerenciarTema({Key? key, required this.title, required this.tema}) : super(key: key);

  final Tema tema;
  final String title;

  @override
  State<TelaGerenciarTema> createState() => _TelaGerenciarTemaState();
}


class _TelaGerenciarTemaState extends State<TelaGerenciarTema> {

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
        title: Text(widget.title),
      ),
      body: _stream_builder_perguntas(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[800],
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => TelaPersistenciaQuizz(tema: widget.tema, edicao: false)))
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

    var perguntas = widget.tema.perguntas;

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

      var novoBotao = botao(perguntas[i].pergunta, _abrirModalOpcoes, 80);
      lista.add(novoBotao);
    }

    return Column(children: lista);
  }

  List<botaoOpcao> _getOpcoesQuestionario(Pergunta p) {
    Function redirecionarTelaEdicao = () {
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (context) => TelaPersistenciaQuizz(pergunta: p, tema: widget.tema, edicao: true)));
    };

    Function chamaDelecao = () {
        _controlePersistenciaPerguntas.delete(context, p);
        widget.tema?.perguntas.remove(p);
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