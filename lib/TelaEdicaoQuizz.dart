
import 'package:flutter/material.dart';
import 'package:quiz/TelaCriacaoPergunta.dart';
import 'package:quiz/TelaEdicaoPergunta.dart';
import 'package:quiz/Utils.dart';
import 'package:quiz/mock.dart';

class TelaEdicao extends StatefulWidget {
  late Questionario questionario;

  TelaEdicao(this.questionario);

  _TelaEdicaoState createState()=> _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text('EDITAR QUIZZ')),
        backgroundColor: Colors.blueGrey[600],
        body:
        SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _getListaBotoes(),
              ],
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[800],
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TelaCriacaoPergunta())).then((value) => setState(() {}));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getListaBotoes(){
    List<botao> lista = [];

    for(int i = 0; i < widget.questionario.perguntas.length; i++){

      void _abrirModalOpcoes() =>{

        showModalBottomSheet(context: context,
            builder: (context){
              return Column(
                children:
                _getOpcoesPergunta(widget.questionario.perguntas[i]),
              );
            })
      };

      var novoBotao = botao(widget.questionario.perguntas[i].pergunta, _abrirModalOpcoes, 80);
      lista.add(novoBotao);
    }

    return Column(
        children: lista
    );
  }

  List<botaoOpcao> _getOpcoesPergunta(Pergunta p){

    Function redirecionarTelaEdicao =
              () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TelaEdicaoPergunta(p)));
                };

    List<botaoOpcao> opcoes = [
      botaoOpcao("Editar", redirecionarTelaEdicao),
      botaoOpcao("Excluir", null),
    ];

    return opcoes;
  }

}