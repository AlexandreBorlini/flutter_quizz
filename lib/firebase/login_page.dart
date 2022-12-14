import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/pages/gerenciar_quiz_page.dart';

import '../util/Utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late bool _passwordVisible = false;
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
            keyboardType: TextInputType.text,
            controller: _passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'Senha',
              hintText: 'Digite sua senha',
              suffixIcon: IconButton(
                icon: Icon(
                  _passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
            ),

          ),
          ElevatedButton(onPressed: _signIn, child: const Text('Entrar'))
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      UserCredential userCredential =
          await _fireBaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      if (userCredential != null) {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => const CadastroQuizPage()))
            .then((value) => setState(() {}));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        snackbarError(context, "Usu??rio n??o encontrado!");
      } else if (e.code == 'wrong-password') {
        snackbarError(context, "Senha inv??lida!");
      }
    }
  }

  Future<void> _signOut() async {
    await _fireBaseAuth.signOut();
  }

}
