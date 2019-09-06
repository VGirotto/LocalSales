import 'package:flutter/material.dart';
import 'package:flutter_app/edit_profile.dart';

bool isSwitched = false;

void main() {
  //run my App
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                                      image: AssetImage("images/a.jpg")))))),
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
                          hintText: "Augusto César Campos Rocha"
                        ),
                      )
                  ),
                  new Padding(
                      padding: EdgeInsets.all(10.0),
                      child: new TextField(
                        enabled: false,
                        decoration: new InputDecoration(
                            hintText: "augusto.rochacampos@gmail.com"
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
                  )
                ],
              ),
      )
    );
  }
}
