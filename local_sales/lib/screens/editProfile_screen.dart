import 'package:flutter/material.dart';

bool isSwitched = false;

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
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'Beatriz Girotto de Claudião',
                        labelText: "Full Name"
                    ),
                  )
              ),
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                        hintText: 'you@example.com',
                        labelText: "E-mail Adress"
                    ),
                  )
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                  enabled: isSwitched,
                  decoration: new InputDecoration(
                      hintText: 'PicPay User',
                      labelText: '@nickname'
                  ),
                ),
              ),
              new Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: new InputDecoration(
                      labelText: 'Celular para contato:'
                  ),
                ),
              )
            ],
          ),
        )
    );
  }
}
