import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                TextFormField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  controller: _emailController,
                ),
                RaisedButton(
                  onPressed: () {
                    var a = FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
                    a.whenComplete(showAlertDialog1(context));
                    //Navigator.pop(context);
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

  showAlertDialog1(BuildContext context)
  {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Recuperação de Senha"),
      content: Text("Email Enviado com Sucesso!"),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

}

