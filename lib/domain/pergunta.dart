class Pergunta {
  String idUsuario;
  String tema;
  String pergunta;
  String respostaCorreta;
  List<String> respostasErradas;

  Pergunta(this.idUsuario, this.tema, this.pergunta, this.respostaCorreta, this.respostasErradas);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['tema'] = tema;
    data['pergunta'] = pergunta;
    data['resposta_correta'] = respostaCorreta;
    data['respostas_erradas'] = respostasErradas;
    return data;
  }
}
