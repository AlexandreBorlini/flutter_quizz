class Pergunta {
  String? idUsuario;
  String? tema;
  String? pergunta;
  String? respostaCorreta;
  List<String> respostasErradas = [];

  Pergunta(this.idUsuario, this.tema, this.pergunta, this.respostaCorreta, this.respostasErradas);

  Pergunta.fromMap(Map<String, dynamic> data) {
    idUsuario = data['id_usuario'];
    tema = data['tema'];
    pergunta = data['pergunta'];
    respostaCorreta = data['resposta_correta'];
    respostasErradas =  (data['respostas_erradas'] as List<dynamic>?)?.cast<String>() ?? [];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_usuario'] = idUsuario;
    data['tema'] = tema;
    data['pergunta'] = pergunta;
    data['resposta_correta'] = respostaCorreta;
    data['respostas_erradas'] = respostasErradas;
    return data;
  }

  String getTema(){
    return tema ?? '';
  }
}
