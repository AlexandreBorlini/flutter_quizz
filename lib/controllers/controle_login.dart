import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/firebase/login_page.dart';


class ControleTelaLogin {
  void inicializarAplicacao(BuildContext context) {
    Future future = Future.delayed(Duration(seconds: 1));

    future.then((value) => {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator
            .of(context)
            .push(MaterialPageRoute(builder: (context)=> const LoginPage()));
      }
      })
    });
}}
