import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pages/cadastro_quiz_page.dart';
import 'package:quiz/pages/home_page.dart';

import '../Utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fireBaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela de Login"),
      ),
      body: ListView(
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(label: Text('email')),
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(label: Text('senha')),
          ),
          ElevatedButton(onPressed: _login, child: const Text('Entrar'))
        ],
      ),
    );
  }

  _login() async {
    try {
      UserCredential userCredential =
          await _fireBaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => const CadastroQuizPage(title: "CadastroQuizPage")))
            .then((value) => setState(() {}));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackbarError(context, "Usuário não encontrado!");
      } else if (e.code == 'wrong-password') {
        snackbarError(context, "Senha inválida!");
      }
    }
  }
}
