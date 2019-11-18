import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_sales/models/user_model.dart';

class EsqueciSenha extends StatefulWidget {
  @override
  _EsqueciSenhaState createState() => _EsqueciSenhaState();
}

final _emailController = TextEditingController();

class _EsqueciSenhaState extends State<EsqueciSenha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Esqueci a senha')
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Digite um e-mail válido para recuperação de senha:",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                textAlign: TextAlign.center,),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                controller: _emailController,
              ),
              RaisedButton(
                onPressed: () {
                //  await _auth.sendPasswordResetEmail(email: _emailController);
                },
                child: Text("Enviar",
                    style: TextStyle(color: Colors.black, fontSize: 20.0)),
                color: Colors.orange,
              )
            ]
          ),
        ),
        backgroundColor: Colors.white
    );
  }
}