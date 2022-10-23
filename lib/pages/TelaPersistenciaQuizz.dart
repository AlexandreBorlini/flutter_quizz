import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/domain/tema.dart';
import 'package:quiz/util/Utils.dart';

import '../controllers/controle_persistencia_perguntas.dart';
import '../domain/pergunta.dart';

class TelaPersistenciaQuizz extends StatefulWidget {
  late Pergunta? pergunta;
  late Tema? tema;
  late bool edicao;

  TelaPersistenciaQuizz({Key? key, this.pergunta, this.tema, this.edicao = false}) : super(key: key);

  _TelaPersistenciaQuizzState createState() => _TelaPersistenciaQuizzState();
}

class _TelaPersistenciaQuizzState extends State<TelaPersistenciaQuizz> {
  String opcao = "";
  late TextEditingController cTema;
  late TextEditingController _cPergunta;
  late TextEditingController _cRespostaCerta;
  late TextEditingController _cRespostaErrada01;
  late TextEditingController _cRespostaErrada02;
  late TextEditingController _cRespostaErrada03;

  late ControlePersistenciaPerguntas _controlePersistenciaPerguntas;
  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;

  @override
  void initState() {
    super.initState();
    if(widget.tema != null)
      cTema = TextEditingController(text: widget.tema?.tema);
    else
      cTema = TextEditingController(text: widget.pergunta?.tema);
    _cPergunta = TextEditingController(text: widget.pergunta?.pergunta);
    _cRespostaCerta =
        TextEditingController(text: widget.pergunta?.respostaCorreta);
    _cRespostaErrada01 =
        TextEditingController(text: widget.pergunta?.respostasErradas![0]);
    _cRespostaErrada02 =
        TextEditingController(text: widget.pergunta?.respostasErradas![1]);
    _cRespostaErrada03 =
        TextEditingController(text: widget.pergunta?.respostasErradas![2]);
    user = auth.currentUser!;
    _controlePersistenciaPerguntas = ControlePersistenciaPerguntas(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('CRIAR QUIZZ')),
        backgroundColor: Colors.blueGrey[600],
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              campoTexto('Tema', controller: cTema, cor: Colors.blue, editavel: widget.tema == null),
              campoTexto('Pergunta', controller: _cPergunta, cor: Colors.blue),
              SizedBox(height: 40),
              campoTexto('Certo',
                  controller: _cRespostaCerta, cor: Colors.green),
              campoTexto('Errado',
                  controller: _cRespostaErrada01, cor: Colors.red),
              campoTexto('Errado',
                  controller: _cRespostaErrada02, cor: Colors.red),
              campoTexto('Errado',
                  controller: _cRespostaErrada03, cor: Colors.red),
              botao("Salvar", _criarQuestionario, 40),
              SizedBox(height: 200)
            ],
          ),
        ));
  }

  void _criarQuestionario() {
    if (_cPergunta.text.isEmpty)
      snackbarError(context, "A pergunta deve ser preenchida");
    else if (cTema.text.isEmpty)
      snackbarError(context, "O tema deve ser preenchido");
    else if (_cRespostaCerta.text.isEmpty ||
        _cRespostaErrada01.text.isEmpty ||
        _cRespostaErrada02.text.isEmpty ||
        _cRespostaErrada03.text.isEmpty)
      snackbarError(context, "Todas as respostas devem ser preenchidas");
    else {
      Pergunta pergunta = Pergunta(
          user.uid, cTema.text, _cPergunta.text, _cRespostaCerta.text, [
        _cRespostaErrada01.text,
        _cRespostaErrada02.text,
        _cRespostaErrada03.text
      ]);

      _controlePersistenciaPerguntas.save(context, pergunta);

      // Como o tema ja esta carregado com suas perguntas, é necessário atualizá-las
      // manualmente para fazer a separação por temas novamente
      var encontrou = false;

      // Se for EDICAO ve se nao foi alterado titulo, se sim, é na verdade inclusao
      // se não, atualiza aquele item dentro do tema
      if (widget.edicao) {
        var tamanhoTema = widget.tema?.perguntas.length ?? 0;
        for (var i = 0; i < tamanhoTema; i++) {
          if (widget.tema?.perguntas[i].pergunta == _cPergunta.text) {
            widget.tema?.perguntas[i] = pergunta;
            encontrou = true;
          }
        }

        if (encontrou == false)
          widget.tema!.perguntas.add(pergunta);
      }

      setState(() {
        if (widget.pergunta != null) {
          Navigator.pop(context);
        }
        Navigator.pop(context);
      });
    }
  }
}

