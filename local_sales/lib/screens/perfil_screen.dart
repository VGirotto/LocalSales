import 'package:flutter/material.dart';
import 'package:local_sales/screens/editProfile_screen.dart';

bool isSwitched = false;

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  TextEditingController _novasenha = TextEditingController();
  TextEditingController _verificasenha = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        title: Text("Informações do Usuário"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
=======
        appBar: AppBar(
          title: Text("Informações do Usuário"),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
>>>>>>> Augusto
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
            )
          ],
        ),
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
                      child: new Text(
                        "Augusto Rocha",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.black45),
                      ))),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextField(
                    enabled: false,
                    decoration: new InputDecoration(
                      labelText: 'Nome: \n\n Augusto César Campos Rocha',
                    ),
                  )),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextField(
                    enabled: false,
                    decoration: new InputDecoration(
                      labelText: 'Email: \n\n augusto.rochacampos@gmail.com',
                    ),
                  )),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextField(
                    enabled: false,
                    decoration: new InputDecoration(
                      labelText: 'Data de Nascimento: \n\n 21/01/1999',
                    ),
                  )),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _novasenha,
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha:\n\n **********',
                  ),
<<<<<<< HEAD
                         new Padding(
                        padding: EdgeInsets.all(10.0),
            child: new Container(
                height: 50.0,
                alignment: Alignment.center,

                child: RaisedButton(
                  color: Colors.orange,
                  onPressed: (){
                    if(_formKey.currentState.validate())
                      print("1");
                  },
                  child: Text("Submeter", style: TextStyle(color: Colors.white),),

=======
>>>>>>> Augusto
                ),
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextField(
                    enabled: false,
                    decoration: new InputDecoration(
                      labelText: 'Telefone: \n\n 11970707070',
                    ),
                  )),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  enabled: false,
                  decoration: new InputDecoration(
                      hintText: 'PicPay User', labelText: 'PicPay:\n\n @augusto.rochacampos'),
                ),
              ),
            ],
          ),
        ));
  }
}
