import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/domain/opcao.dart';
import 'package:quiz/domain/pergunta.dart';
import 'package:quiz/util/Utils.dart';

import '../domain/tema.dart';

class PraticaPage extends StatefulWidget {
  const PraticaPage({Key? key, required this.tema}) : super(key: key);

  final Tema tema;

  @override
  State<PraticaPage> createState() => _PraticaPageState();
}


class _PraticaPageState extends State<PraticaPage> {

  int _questionNumber = 0;
  int _quantidadeAcertos = 0;
  bool _escolheuOpcao = false;
  bool _terminouQuestionario = false;
  List<Opcao> ordemOpcoesSalvas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[600],
      appBar: AppBar(
          title: Text(widget.tema.tema ?? '')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 22,),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 18, 6),
            child: Text('Questão ${_questionNumber + 1}/${widget.tema.perguntas.length}', style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              ),
            ),
        ),
          const Divider(thickness: 1, color: Colors.white),
      Visibility(
          visible: !_terminouQuestionario,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 40),
                child: Text(widget.tema.perguntas[_questionNumber].pergunta ?? '', style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                ),
                ),
              ),

              montarQuestao(
                  widget.tema.perguntas[_questionNumber]),
              Visibility(
                child: botao("Próxima questão", proximaQuestao, 40),
                visible: _escolheuOpcao,
              ),
            ],
          )
      ),
      Visibility(
        visible: _terminouQuestionario,
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 18, 0, 40),
                child: Text('Acertos: $_quantidadeAcertos/${widget.tema.perguntas.length}', style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  ),
                ),
              ),
              botao("Sair do questionário", sairQuestionario, 40)
            ]
          ),
        ),
        ],
      ),
    );
  }

  void sairQuestionario(){
    setState(() {
      Navigator.pop(context);
    });
  }

  void escolherOpcaoErrada(){
    setState(() {
      _escolheuOpcao = true;
    });
  }
  void escolherOpcaoCerta(){
    setState(() {
      _escolheuOpcao = true;
      _quantidadeAcertos++;
    });
  }

  void proximaQuestao(){
    setState(() {

      if(widget.tema.perguntas.length > _questionNumber+1){
        ordemOpcoesSalvas = [];
        _escolheuOpcao = false;
        _questionNumber++;
      } else {
        // vai para a página de resultados
        _terminouQuestionario = true;
      }
    });
  }

  Column montarQuestao( Pergunta p){

    List<Opcao> opcoes = getOpcoes(widget.tema.perguntas[_questionNumber]);

    // renderiza os botões
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          botao(opcoes[0].texto, opcoes[0].correto ? escolherOpcaoCerta : escolherOpcaoErrada, 40, cor: _escolheuOpcao && opcoes[0].correto ? Colors.green : null, disabilitado: _escolheuOpcao),
          botao(opcoes[1].texto, opcoes[1].correto ? escolherOpcaoCerta : escolherOpcaoErrada, 40, cor: _escolheuOpcao && opcoes[1].correto ? Colors.green : null, disabilitado: _escolheuOpcao),
          botao(opcoes[2].texto, opcoes[2].correto ? escolherOpcaoCerta : escolherOpcaoErrada, 40, cor: _escolheuOpcao && opcoes[2].correto ? Colors.green : null, disabilitado: _escolheuOpcao),
          botao(opcoes[3].texto, opcoes[3].correto ? escolherOpcaoCerta : escolherOpcaoErrada, 40, cor: _escolheuOpcao && opcoes[3].correto ? Colors.green : null, disabilitado: _escolheuOpcao),
        ]
    );
  }

  List<Opcao> getOpcoes(Pergunta p){

    if(ordemOpcoesSalvas.length != 0){
      return ordemOpcoesSalvas;
    }

    List<Opcao> opcoes = [];

    Opcao no = new Opcao(p.respostaCorreta ?? '', true, false);
    opcoes.add(no);
    p.respostasErradas.forEach((element) {
      Opcao no = new Opcao(element, false, false);
      opcoes.add(no);
    });
    shuffle(opcoes);
    ordemOpcoesSalvas = opcoes;
    return opcoes;
  }
}

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }