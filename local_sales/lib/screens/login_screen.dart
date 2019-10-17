import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:local_sales/screens/esqueciSenha_screen.dart';
import 'package:local_sales/screens/feed_screen.dart';
import 'package:local_sales/screens/cadastro_screen.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class EmailFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'Email cannot be empty' : null;
  }
}

class PasswordFieldValidator{
  static String validate(String value){
    return value.isEmpty ? 'Password cannot be empty' : null;
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading)
            return Center(child: CircularProgressIndicator(),);

          return ListView(
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
                  style: TextStyle(fontSize: 30.0, color: Colors.orange),
                  textAlign: TextAlign.center),
              TextFormField(
                validator: EmailFieldValidator.validate,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "E-mail:",
                  labelStyle: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              TextFormField
                (
                validator: PasswordFieldValidator.validate,
                controller: _passController,
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
                  model.signIn(
                    email: _emailController.text,
                    pass: _passController.text,
                    onSucess: _onSucess,
                    onFail: _onFail
                  );
                },
                child: Text("Entrar",
                  style: TextStyle(color: Colors.black, fontSize: 20.0)),
                color: Colors.orange,
              ),
              FlatButton(
                onPressed: () {
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
            padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 20.0),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  void _onSucess() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Feed())
    );
  }

  void _onFail() {

    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao fazer login, verifique email e senha."),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

