import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();
  String _pass = "", t1 = 'Show Password', t2 = "Show Password";
  bool isSwitched = false, isChecked1 = false, isChecked2 = false;
  String _img_path;

  final date = new RegExp(r"\d\d[^\w]\d\d[^\w]\d\d\d\d");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
            padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
            children: <Widget>[
              Container(
                  child: new Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("lib/assets/Logo.png")))))),
              Container(
                child: new Text('LocalSales',
                    style: TextStyle(fontSize: 40, color: Colors.orange),
                    textAlign: TextAlign.center),
              ),
              Container(
                  child: new TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'you@example.com',
                      labelText: "E-mail Adress",
                      prefixIcon: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: Colors.orange,
                      ),
                    ),
                    validator: (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                  )),

              Container(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: !isChecked1,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 30,
                        color: Colors.orange,
                      )),
                  validator: (_pass) {
                    if (_pass.isEmpty || _pass.length < 6)
                      return "Senha inválida!";
                  },
                ),
              ),

              new Row(
                  children: <Widget>[
                    new Text(t1),
                    new Checkbox(
                        value: isChecked1,
                        checkColor: Colors.orange,
                        activeColor: Colors.orange,
                        onChanged: (value){
                          setState(() {
                            isChecked1 = value;
                            t1 = (isChecked1 == true)?'Hide Password': 'Show Password';
                          });
                        }
                    ),
                  ]
              ),

              Container(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: !isChecked2,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      labelText: 'Reenter the Password',
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 30,
                        color: Colors.orange,
                      )),
                  validator: (text) {
                    if (text.isEmpty || text.length < 6) {
                      return "Senha inválida";
                    } else if (text != _pass) {
                      return "As senhas não conferem!";
                    }
                  },
                ),
              ),

              new Row(
                  children: <Widget>[

                    new Text(t2),
                    new Checkbox(
                        value: isChecked2,
                        activeColor: Colors.orange,
                        checkColor: Colors.orange,
                        onChanged: (value){
                          setState(() {
                            isChecked2 = value;
                            t2 = (isChecked2 == true)?'Hide Password': 'Show Password';
                          });
                        }
                    ),
                  ]
              ),

              Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.account_box,
                      size: 35,
                      color: Colors.orange,
                    ),
                    Text(
                      "Informações Pessoais",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )
                  ])),

              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                          child: Row(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: _img_path != null
                                          ? AssetImage(_img_path)
                                          : NetworkImage(
                                          "https://logodetimes.com/wp-content/uploads/corinthians-capa.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                  child: Container(
                                    width:250,
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelStyle: TextStyle(color: Colors.black),
                                          hintText: "Fulano da Silva",
                                          labelText: 'Display Name',
                                          prefixIcon: Icon(
                                            Icons.contacts,
                                            size: 30,
                                            color: Colors.orange,
                                          )),
                                      validator: (text) {
                                        if (text.isEmpty) return "Nome Inválido!";
                                      },
                                    ),
                                  ),
                              ),
                            ],
                          ),
                    ),
                          onTap: () {
                        showDialog(
                            context: context,
                            child: SimpleDialog(
                              title: Text("Salveee"),
                              children: <Widget>[
                                Text(
                                  "Só mostrando que aqui vai abrir a galeria pra trocar a foto :D",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ));
                      },
                    ),
                    SizedBox(
                      width: 100.0,
                        child: Container(
                          padding: EdgeInsets.only(top: 5, left: 15),
                          child: Text(
                          "User Photo",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                    ),
                    ),
                  ],),),


              Container(
                child: TextFormField(

                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: "01/01/2000",
                      labelText: 'Birthdate',
                      prefixIcon: Icon(
                        Icons.cake,
                        size: 30,
                        color: Colors.orange,
                      )),
                  validator: (text) {
                    if (text.isEmpty || (!date.hasMatch(text)))
                      return "Data Inválida!";
                  },
                ),
              ),

              Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(children: <Widget>[
                    Icon(
                      Icons.attach_money,
                      size: 35,
                      color: Colors.orange,
                    ),
                    Text(
                      "Métodos de Pagamento",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    )
                  ])),

              Container(
                  child: new Row(
                    children: <Widget>[
                      Text("PicPay", textAlign: TextAlign.left),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          activeTrackColor: Colors.orangeAccent,
                          activeColor: Colors.orange,
                        ),
                      ),
                      SizedBox(
                        width: 200.0,
                        child: TextFormField(
                          enabled: isSwitched,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'PicPay user',
                          ),
                          validator: (text) {
                            if (text.isEmpty) return "Conta Inválida!";
                          },
                        ),
                      ),
                    ],
                  )),

              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text(
                      "Criar Conta",
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    textColor: Colors.black,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {}
                    },
                  ),
                ),
              ),
            ]),
      ),

      //, style: TextStyle(color: Colors.white, fontSize: 40))//,
      //Text('Senha', style: TextStyle(color: Colors.white,fontSize: 20, height: 5.0)),
      //Text('email', style: TextStyle(color: Colors.white, fontSize: 20, height: 5.0)),
      //Text('Informações pessoais', style: TextStyle(color: Colors.white, fontSize: 40, height:5.0)),
      //Text('Formas de pagamento', style: TextStyle(color: Colors.white,fontSize: 20, height: 5.0))
      backgroundColor: Colors.white,
    );
  }
}

