
import 'package:flutter/material.dart';
import 'package:quiz/TelaEdicaoQuizz.dart';
import 'package:quiz/Utils.dart';
import 'package:quiz/mock.dart';

import 'TelaCriacaoQuizz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'QUIZZ APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TelaCriacao())).then((value) => setState(() {}));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _getListaBotoes(context){
    List<botao> lista = [];

    for(int i = 0; i < questionarios.length; i++){

      void _abrirModalOpcoes(){
        showModalBottomSheet(context: context,
            builder: (context){
              return Column(
                children:
                _getOpcoesQuestionario(questionarios[i]),
              );
            });
      }

      var novoBotao = botao(questionarios[i].nome, _abrirModalOpcoes, 80);
      lista.add(novoBotao);
    }

    return Column(
        children:
        lista
    );
  }

  List<botaoOpcao> _getOpcoesQuestionario(Questionario q){

    Function redirecionarTelaEdicao = (){
      Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=> TelaEdicao(q)))
            .then((value) => setState(() {}));
    };


    List<botaoOpcao> opcoes = [
      botaoOpcao("Editar", redirecionarTelaEdicao),
      botaoOpcao("Excluir", null),
    ];

    return opcoes;
  }

}