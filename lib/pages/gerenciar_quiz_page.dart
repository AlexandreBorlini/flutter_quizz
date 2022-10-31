import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/domain/pergunta.dart';
import 'package:quiz/domain/tema.dart';
import 'package:quiz/pages/gerenciar_tema.dart';
import 'package:quiz/pages/praticar_tema_page.dart';

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
        title: const Text("GERENCIAMENTO QUIZZ"),
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

    List<Tema> temas = [];

    for (int i = 0; i < perguntas!.length; i++) {
      bool existeTema = false;
      for (int j = 0; j < temas.length; j++) {
        if(perguntas[i].getTema() == temas[j].tema){
          temas[j].perguntas?.add(perguntas[i]);
          existeTema = true;
        }
      }

      if(!existeTema){
        List<Pergunta> listaperg = [];
        listaperg.add(perguntas[i]);
        Tema nt = new Tema(perguntas[i].getTema(), listaperg);
        temas.add(nt);
      }
    }

    for (int i = 0; i < temas.length; i++) {
      void _abrirModalOpcoes() {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: _getOpcoesQuestionario(temas[i]),
              );
            });
      }

      var novoBotao = botao(temas[i].tema, _abrirModalOpcoes, 80);
      lista.add(novoBotao);
    }

    return Column(children: lista);
  }

  List<botaoOpcao> _getOpcoesQuestionario(Tema t) {

    void redirecionarTelaEdicaoTema(){
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (context) => TelaGerenciarTema(title: t.tema ?? '', tema: t)));
    }

    void redirecionarTelaPratica(){
      Navigator.of(context)
          .push(MaterialPageRoute(
          builder: (context) => PraticaPage(tema: t)));
    }

    Function chamaDelecao = () {
      var quantidadePerguntas = t.perguntas?.length ?? 0;
      for(var i = 0; i < quantidadePerguntas; i++){

        _controlePersistenciaPerguntas.delete(context, t.perguntas[i]);
      }

      setState(() {
        Navigator.pop(context);
      });
    };

    List<botaoOpcao> opcoes = [
      botaoOpcao("Praticar", redirecionarTelaPratica),
      botaoOpcao("Editar", redirecionarTelaEdicaoTema),
      botaoOpcao("Excluir", chamaDelecao),
    ];

    return opcoes;
  }
}
