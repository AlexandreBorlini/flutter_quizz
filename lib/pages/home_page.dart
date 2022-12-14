import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controllers/controle_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ControleTelaLogin _controleTelaLogin = ControleTelaLogin();
  String opcao = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[600],
        appBar: AppBar(
          title: const Text("Sig In or Sign Out"),
            actions: <Widget>[
            Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  _controleTelaLogin.irParaTelaLogin(context);
                },
                child: const Icon(Icons.login, color: Colors.green)
            )
        ),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        _controleTelaLogin.realizarLogOut(context);
                      },
                      child: const Icon(Icons.logout, color: Colors.red,)
                  )
              ),
            ]
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: Text("Quiz App",
              style: TextStyle(color: Colors.blue, fontSize: 32),),
          )
        ));
  }
}
