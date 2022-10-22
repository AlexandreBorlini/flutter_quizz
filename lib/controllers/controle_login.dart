import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/firebase/login_page.dart';
import 'package:quiz/pages/gerenciar_quiz_page.dart';

import '../util/Utils.dart';


class ControleTelaLogin {
  void irParaTelaLogin(BuildContext context) {
    Future future = Future.delayed(Duration(seconds: 1));

    future.then((value) => {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (context)=> const LoginPage()));
      }
      else{
        snackbarSuccess(context, "Usuário já se encontra logado, redirecionando para a página do Quiz!");
        Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (context)=> const CadastroQuizPage()));
      }
      })
    });
}
  Future<void> realizarLogOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    snackbarSuccess(context, "LogOut realizado!");
  }
}
