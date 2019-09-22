import 'package:flutter/material.dart';

bool isSwitched = false;
TextEditingController _PicPay = new TextEditingController(text: 'augusto.rochacampos');
TextEditingController _phone = new TextEditingController(text: '11970707070');
TextEditingController _birth = new TextEditingController(text: '21011999');

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edições do Usuário"),
          centerTitle: true,
          backgroundColor: Colors.orange,
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
                    initialValue: 'Augusto César Campos Rocha',
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        labelText: "Nome Completo"
                    ),
                  )
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextFormField(
                    initialValue: 'augusto.rochacampos@gmail.com',
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
                    enabled: false,
                    decoration: new InputDecoration(
                      labelText: 'Data de Nascimento',
                    ),
                  )),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  initialValue: 'lalakekeroro123',
                  decoration: InputDecoration(
                    //hintText: 'Password',
                    labelText: 'Enter your password',

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
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
                      labelText: 'Telefone'
                  ),
                ),
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
            ],
          ),
        )
    );
  }
}
