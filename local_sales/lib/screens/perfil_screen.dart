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
      appBar: AppBar(
        title: Text("Informações do Usuário"),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
          )
        ],
      ),
      //drawer: CustomDrawer(),
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
                      )
                  ),
                  new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new TextField(
                        enabled: false,
                        decoration: new InputDecoration(

                          labelText: 'Email: \n\n augusto.rochacampos@gmail.com',
                        ),
                      )
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _novasenha,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Enter your new password',

                      ),
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: _verificasenha,
                      obscureText: true,
                      validator: (value){
                          if(value.isEmpty) {return "Senhas digitadas incorretamente";}
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Confirm your new password',

                      ),
                    ),
                  ),
                         new Padding(
                        padding: EdgeInsets.all(10.0),
            child: new Container(
                height: 50.0,
                alignment: Alignment.center,

                child: RaisedButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: (){
                    if(_formKey.currentState.validate())
                      print("1");
                  },
                  child: Text("Submeter", style: TextStyle(color: Colors.white),),

                ),
            )),
                  new Padding(padding: EdgeInsets.all(10.0),
                  child: new Row(
                    children: <Widget>[
                      Text(
                          "PicPay",
                          textAlign: TextAlign.left
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Switch(
                          value: isSwitched,
                          onChanged: (value){
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          activeTrackColor: Colors.deepOrangeAccent,
                          activeColor: Colors.deepOrange,
                        ),
                      )
                    ],
                  )
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      enabled: isSwitched,
                      decoration: new InputDecoration(
                        hintText: 'PicPay User',
                        labelText: '@nickname'
                      ),
                    ),
                  )
                ],
              ),
      )
    );
  }
}