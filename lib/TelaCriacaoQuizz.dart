
import 'package:flutter/material.dart';
import 'package:quiz/Utils.dart';
import 'package:quiz/mock.dart';

class TelaCriacao extends StatefulWidget {
  _TelaCriacaoState createState()=> _TelaCriacaoState();
}

class _TelaCriacaoState extends State<TelaCriacao> {

  String opcao = "";
  late TextEditingController cTitulo;
  late TextEditingController _cPergunta;
  late TextEditingController _cRespostaCerta;
  late TextEditingController _cRespostaErrada01;
  late TextEditingController _cRespostaErrada02;
  late TextEditingController _cRespostaErrada03;

  @override
  void initState() {
    super.initState();
    cTitulo = TextEditingController();
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
              campoTexto('Nome Quizz', controller: cTitulo, cor: Colors.blue),
              campoTexto('Pergunta', controller: _cPergunta, cor: Colors.blue),
              SizedBox(height: 40),
              campoTexto('Certo', controller: _cRespostaCerta, cor: Colors.green),
              campoTexto('Errado', controller: _cRespostaErrada01, cor: Colors.red),
              campoTexto('Errado', controller: _cRespostaErrada02, cor: Colors.red),
              campoTexto('Errado', controller: _cRespostaErrada03, cor: Colors.red),
              botao("Criar", _criarQuestionario, 40),
              SizedBox(height: 200)
            ],
          ),
        )
    );
  }

  void _criarQuestionario() {
    if (_cPergunta.text.isEmpty)
      snackbarError(context, "A pergunta deve ser preenchida");
    else if (cTitulo.text.isEmpty)
      snackbarError(context, "O título deve ser preenchido");
    else if (_cRespostaCerta.text.isEmpty || _cRespostaErrada01.text.isEmpty ||
        _cRespostaErrada02.text.isEmpty || _cRespostaErrada03.text.isEmpty)
      snackbarError(context, "Todas as respostas devem ser preenchidas");
    else {
      Pergunta pergunta = Pergunta(_cPergunta.text, _cRespostaCerta.text,
          [
            _cRespostaErrada01.text,
            _cRespostaErrada02.text,
            _cRespostaErrada03.text
          ]);
      Questionario novoQuestionario = Questionario(cTitulo.text, [pergunta]);
      questionarios.add(novoQuestionario);

      setState(() {
        Navigator.pop(context);
      });
    }
  }
}