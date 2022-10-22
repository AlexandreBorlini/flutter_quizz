
import 'package:flutter/material.dart';
import 'package:quiz/util/Utils.dart';
import 'package:quiz/domain/static.dart';

class TelaCriacaoPergunta extends StatefulWidget {
  _TelaCriacaoPerguntaState createState()=> _TelaCriacaoPerguntaState();
}

class _TelaCriacaoPerguntaState extends State<TelaCriacaoPergunta> {

  late TextEditingController _cPergunta;
  late TextEditingController _cRespostaCerta;
  late TextEditingController _cRespostaErrada01;
  late TextEditingController _cRespostaErrada02;
  late TextEditingController _cRespostaErrada03;

  @override
  void initState() {
    super.initState();
    _cPergunta = TextEditingController();
    _cRespostaCerta = TextEditingController();
    _cRespostaErrada01 = TextEditingController();
    _cRespostaErrada02 = TextEditingController();
    _cRespostaErrada03 = TextEditingController();
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
              botao("Criar", _criarPergunta, 40),
              SizedBox(height: 200)
            ],
          ),
        )
    );
  }

  void _criarPergunta(){
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