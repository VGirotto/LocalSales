import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';



import 'package:local_sales/models/user_model.dart';

bool isSwitched = false;


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {


  static TextEditingController _PicPay = new TextEditingController();
  static TextEditingController _phone  = new TextEditingController();
  static TextEditingController _birth  = new TextEditingController();
  static TextEditingController _name   = new TextEditingController();
  static TextEditingController _email  = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edições do Usuário"),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
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
                  child: new TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        labelText: "Nome Completo"
                    ),
                  )
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(

                        labelText: "Endereço de Email"
                    ),
                  )
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextField(
                    controller: _birth,
                    enabled: true,
                    decoration: new InputDecoration(
                      labelText: 'Data de Nascimento',
                    ),
                  )),

              new Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
                      labelText: 'Telefone'
                  ),
                ),
              ),
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
                          onChanged: (value) {
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
                  controller: _PicPay,
                  enabled: isSwitched,
                  decoration: new InputDecoration(
                      hintText: 'PicPay User',
                      labelText: '@nickname'
                  ),
                ),
              ),
              new Padding(padding: EdgeInsets.all(10.0),
                child: RaisedButton(
                  color: Colors.deepOrange,
                  child: Text("Submeter",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white,
                        fontSize: 18.0
                    ),
                  ),
                  onPressed: () async{

                    Map<String, dynamic> new_data = {
                      "name": _name.text,
                      "email": _email.text,
                      "birth": _birth.text,
                      "picpay": _PicPay.text,
                      "phone": _phone.text,
                    };

                    print(new_data);

                    await UserModel().update_base(userData: new_data);

                    Navigator.pop(context);

                  },
                ),)
            ],
          ),
        )
    );
  }

}
