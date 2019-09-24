import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/screens/editProfile_screen.dart';
import 'package:scoped_model/scoped_model.dart';

bool isSwitched = false;

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 190.0,
                          height: 190.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("images/Augusto.jpg")))))),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Align(
                      alignment: Alignment.center,
                      child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model){
                                  return Text(
                                    "${model.currentUser() == null ? "Fail" : model.userData["name"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 15, color: Colors.black45),
                                  );
                                }
                            )
                  )
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model){
                                  return new TextField(
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "Nome: \n\n ${model.currentUser() == null ? "Fail" : model.userData["name"]}",
                                    ),
                                  );
                                }
                            )
                  ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model){
                                  return new TextField(
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "E-mail: \n\n ${model.currentUser() == null ? "Fail" : model.userData["email"]}",
                                    ),
                                  );
                                }
                            )
                  ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model){
                                  return new TextField(
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "Data de Nascimento: \n\n ${model.currentUser() == null ? "Fail" : model.userData["birth"]}",
                                    ),
                                  );
                                }
                            )
                  ),

              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model){
                                  return new TextField(
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "Telefone: \n\n ${model.currentUser() == null ? "Fail" : model.userData["phone"]}",
                                    ),
                                  );
                                }
                            )
                  ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ScopedModelDescendant<UserModel>(
                                builder: (context, child, model){
                                  return new TextField(
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      labelText: "Usuário do PicPay: \n\n ${model.currentUser() == null ? "Fail" : model.userData["picpay"]}",
                                    ),
                                  );
                                }
                            )
                  ),
            ],
          ),
        ));
  }
}
