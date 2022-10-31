import 'dart:ffi';

class Opcao {
  String texto;
  bool correto;
  bool isLocked;

  Opcao(this.texto, this.correto, this.isLocked);
}