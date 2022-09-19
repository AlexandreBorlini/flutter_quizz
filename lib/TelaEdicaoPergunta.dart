import 'package:flutter/material.dart';
import 'package:quiz/Utils.dart';
import 'package:quiz/mock.dart';

class TelaEdicaoPergunta extends StatefulWidget {

  late Pergunta pergunta;

  TelaEdicaoPergunta(this.pergunta);

  _TelaEdicaoPerguntaState createState()=> _TelaEdicaoPerguntaState();
}

class _TelaEdicaoPerguntaState extends State<TelaEdicaoPergunta> {

  final TextEditingController _cPergunta = TextEditingController();
  final TextEditingController _cRespostaCerta = TextEditingController();
  final TextEditingController _cRespostaErrada01 = TextEditingController();
  final TextEditingController _cRespostaErrada02 = TextEditingController();
  final TextEditingController _cRespostaErrada03 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cPergunta.text = widget.pergunta.pergunta;
    _cRespostaCerta.text = widget.pergunta.respostaCorreta;
    _cRespostaErrada01.text = widget.pergunta.respostasErradas[0];
    _cRespostaErrada02.text = widget.pergunta.respostasErradas[1];
    _cRespostaErrada03.text = widget.pergunta.respostasErradas[2];
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text('CRIAR QUIZZ')),
        backgroundColor: Colors.blueGrey[600],
        body:
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              campoTexto('Pergunta', controller: _cPergunta, cor: Colors.blue),
              SizedBox(height: 40),
              campoTexto('Certo', controller: _cRespostaCerta, cor: Colors.green),
              campoTexto('Errado', controller: _cRespostaErrada01, cor: Colors.red),
              campoTexto('Errado', controller: _cRespostaErrada02, cor: Colors.red),
              campoTexto('Errado', controller: _cRespostaErrada03, cor: Colors.red),
              botao("Criar", _editarPergunta, 40),
              SizedBox(height: 200)
            ],
          ),
        )
    );
  }

  void _editarPergunta(){
    if (_cPergunta.text.isEmpty)
      snackbarError(context, "A pergunta deve ser preenchida");
    else if (_cRespostaCerta.text.isEmpty || _cRespostaErrada01.text.isEmpty ||
        _cRespostaErrada02.text.isEmpty || _cRespostaErrada03.text.isEmpty)
      snackbarError(context, "Todas as respostas devem ser preenchidas");
    else{
      setState((){
        Navigator.pop(context);
      });
    }
  }
}