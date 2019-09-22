import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:local_sales/screens/esqueciSenha_screen.dart';
import 'package:local_sales/screens/feed_screen.dart';
import 'package:local_sales/screens/cadastro_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.all(10.0),
            child: new Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 150.0,
                height: 150.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/Logo.png"),
                  ),
                ),
              ),
            ),
          ),
          Text('Local Sales',
              style: TextStyle(fontSize: 30.0, color: Colors.orange), textAlign: TextAlign.center),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Login:",
              labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          TextField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Senha:",
              labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            textAlign: TextAlign.center,
            obscureText: true,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Feed())
              );
            },
            child: Text("Entrar",
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
              color: Colors.orange,
          ),
          FlatButton(
            onPressed: () {
              Firestore.instance.collection("Teste").document("Test").setData({"oi":"ola"});
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => EsqueciSenha())
              );
            },
            child: Text("Esqueci a senha",
                style: TextStyle(fontSize: 15.0, color: Colors.orange)),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => Cadastro())
              );
            },
            child: Text("Cadastrar uma nova conta",
                style: TextStyle(fontSize: 15.0, color: Colors.orange))
          )
        ],
        padding: EdgeInsets.fromLTRB(20.0,60.0,20.0,20.0),
      ),
      backgroundColor: Colors.white,
    );
  }
}