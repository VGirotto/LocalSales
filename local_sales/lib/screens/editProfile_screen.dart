import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/image/image_picker_handler.dart';


import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/widgets/Images_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

bool isSwitched = false;


class EditProfile extends StatefulWidget {

  EditProfile({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with TickerProviderStateMixin, ImagePickerListener{

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  static TextEditingController _PicPay = new TextEditingController();
  static TextEditingController _phone  = new TextEditingController();
  static TextEditingController _birth  = new TextEditingController();
  static TextEditingController _name   = new TextEditingController();
  static TextEditingController _email  = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker=new ImagePickerHandler(this,_controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

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
              new ScopedModelDescendant<UserModel>
                (builder: (context, child, model){
                  return new GestureDetector(
                    onTap: () => imagePicker.showDialog(context),
                    child: new Center(
                      child: _image == null
                          ? new Stack(
                        children: <Widget>[

                          new Center(
                            child: new CircleAvatar(
                              radius: 80.0,
                              backgroundColor: const Color(0xFF778899),
                            ),
                          ),
                          new Center(
                            child: new Image.asset("assets/photo_camera.png"),
                          ),

                        ],
                      )
                          : new Container(
                        height: 160.0,
                        width: 160.0,
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: new ExactAssetImage(_image.path),
                            fit: BoxFit.cover,
                          ),
                          border:
                          Border.all(color: Colors.red, width: 5.0),
                          borderRadius:
                          new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                      ),
                    ),
                  );
                }
              ),
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
                  child: new TextFormField(
                    controller: _name,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        labelText: "Nome"
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
