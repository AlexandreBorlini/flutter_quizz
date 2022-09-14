
import 'dart:core';

List<Questionario>  questionarios = [];

class Questionario{
  String nome;
  List<Pergunta> perguntas;

  Questionario(
      this.nome,
      this.perguntas
      );
}

class Pergunta {
  String pergunta;
  String respostaCorreta;
  List<String> respostasErradas;

  Pergunta(
      this.pergunta,
      this.respostaCorreta,
      this.respostasErradas
      );
}