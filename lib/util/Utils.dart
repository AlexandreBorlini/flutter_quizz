import 'package:flutter/material.dart';

class botao extends StatelessWidget {
  final String? texto;
  final Function? acao;
  final double? altura;

  const botao(this.texto, this.acao, this.altura, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ElevatedButton(
          onPressed: () {
            acao?.call();
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.blueGrey[300],
              minimumSize: Size(3000, altura!),
              elevation: 2),
          child: Text(texto!,
              style: TextStyle(color: Colors.black87, fontSize: 20)),
        ));
  }
}

class botaoOpcao extends StatelessWidget {
  String texto;
  final Function? acao;

  botaoOpcao(this.texto, this.acao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        acao?.call();
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          minimumSize: const Size(3000, 70),
          elevation: 0),
      child: Text(texto, style: TextStyle(color: Colors.black87, fontSize: 20)),
    );
  }
}

class campoTexto extends StatelessWidget {
  final String nome;
  TextEditingController controller;
  final Color cor;
  bool editavel = true;

  campoTexto(this.nome, {this.cor = Colors.green, required this.controller, this.editavel = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: TextField(
          maxLines: null,
          enabled: editavel,
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              fillColor: Colors.blueGrey[800],
              filled: true,
              contentPadding: EdgeInsets.all(15.0),
              labelText: nome,
              labelStyle: const TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: cor),
                borderRadius: BorderRadius.circular(15),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: cor),
                borderRadius: BorderRadius.circular(15),
              )),
        ),
      ),
    );
  }
}

void snackbarError(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(message),
    ),
  );
}

void snackbarSuccess(context, message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text(message),
    ),
  );
}
