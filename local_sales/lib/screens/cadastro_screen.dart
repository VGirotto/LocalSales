import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_sales/screens/fullPhoto_screen.dart';
import 'package:intl/intl.dart';
import 'package:image_cropper/image_cropper.dart';



class Cadastro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CadastroP();
  }
}

class CadastroP extends StatefulWidget {
  @override
  State createState() => new _CadastroState();
}

class _CadastroState extends State<CadastroP> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _birthController = TextEditingController();
  final _picpay = TextEditingController();
  final _phone = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _pass = "", t1 = 'Show Password', t2 = "Show Password";
  bool isSwitched = false, isChecked1 = false, isChecked2 = false;
  String _img_path;
  File imageFile;
  bool isLoading = false;
  String imageUrl = '';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final date = new RegExp(r"\d\d\/\d\d\/\d\d\d\d");

  @override
  void initState() {
    super.initState();
    isLoading = false;
    imageUrl = '';
  }

  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.grey,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );

  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        //onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  Future getImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    cropImage(imageFile);
    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return Form(
            key: _formKey,
            child: ListView(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 40.0),
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
                                      fit: BoxFit.cover,
                                      image: AssetImage("images/Logo.png")))))),
                  Container(
                    child: new Text('LocalSales',
                        style: TextStyle(fontSize: 40, color: Colors.orange),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.account_box,
                          size: 35,
                          color: Colors.orange,
                        ),
                        Text(
                          "Informações de Login ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        )
                      ])),
                  Container(
                      child: new TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'you@example.com',
                      labelText: "E-mail",
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
                      controller: _passController,
                      keyboardType: TextInputType.text,
                      obscureText: !isChecked1,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Senha',
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 30,
                            color: Colors.orange,
                          )),
                      validator: (text) {
                        _pass = text;
                        if (_pass.isEmpty || _pass.length < 6)
                          return "Senha inválida!";
                      },
                    ),
                  ),
                  new Row(children: <Widget>[
                    new Text(t1),
                    new Checkbox(
                        value: isChecked1,
                        checkColor: Colors.orange,
                        activeColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            isChecked1 = value;
                            t1 = (isChecked1 == true)
                                ? 'Hide Password'
                                : 'Show Password';
                          });
                        }),
                  ]),
                  Container(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      obscureText: !isChecked2,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: 'Repita a Senha',
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
                  new Row(children: <Widget>[
                    new Text(t2),
                    new Checkbox(
                        value: isChecked2,
                        activeColor: Colors.orange,
                        checkColor: Colors.orange,
                        onChanged: (value) {
                          setState(() {
                            isChecked2 = value;
                            t2 = (isChecked2 == true)
                                ? 'Hide Password'
                                : 'Show Password';
                          });
                        }),
                  ]),
                  Container(
                      padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
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
                      ]
                    )
                  ),
                  
                  
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 95,
                          child: ClipOval(
                            child: SizedBox(
                              width: 175.0,
                              height: 175.0,
                              child: Image(
                                image: (imageUrl != "")?NetworkImage(imageUrl)
                                :NetworkImage(
                                "http://www.tuktukdesign.com/wp-content/uploads/2017/12/person-icon.jpg"),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                          backgroundColor: Colors.black12,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors. orange,
                            size: 45.0,
                          ),
                          onPressed: (){
                            getImage();//Pega imagem da galeria
                          },
                        )
                      ),
                    ],
                  ),
                  Container(
                    width: 250,
                    child: TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          color: Colors.black
                          ),
                        hintText: "Fulano da Silva",
                        labelText: 'Nome',
                        prefixIcon: Icon(
                          Icons.contacts,
                          size: 30,
                          color: Colors.orange,
                        )
                      ),
                      validator: (text) {
                        if (text.isEmpty)
                          return "Nome Inválido!";
                      },
                    ),
                  ),
                  
                  
                  
                  /*Container(
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
                                        image: imageUrl != ""
                                            ? NetworkImage(imageUrl)
                                            : NetworkImage(
                                                "https://previews.123rf.com/images/dxinerz/dxinerz1507/dxinerz150700705/42826470-user-select-insert-icon-vector-image-can-also-be-used-for-admin-dashboard-suitable-for-mobile-apps-w.jpg"),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  child: Container(
                                    width: 250,
                                    padding: EdgeInsets.only(left: 10),
                                    child: TextFormField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          hintText: "Fulano da Silva",
                                          labelText: 'Nome',
                                          prefixIcon: Icon(
                                            Icons.contacts,
                                            size: 30,
                                            color: Colors.orange,
                                          )),
                                      validator: (text) {
                                        if (text.isEmpty)
                                          return "Nome Inválido!";
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            getImage();
                            print(imageUrl);
                            print(imageUrl);
                            print(imageUrl);
                            print(imageUrl);
                            print(imageUrl);
                          },
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Container(
                            padding: EdgeInsets.only(top: 5, left: 15),
                            child: Text(
                              "      Foto",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),*/
                  
                  
                  
                  
                  
                  Container(
                    child: TextFormField(
                      controller: _birthController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: "01/01/2000",
                          labelText: 'Data de Nascimento',
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
                      child: new TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: '11970707070',
                      labelText: "Telefone",
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 30,
                        color: Colors.orange,
                      ),
                    ),
                  )),
                  Container(
                      padding: EdgeInsets.only(top: 30.0),
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
                          controller: _picpay,
                          enabled: isSwitched,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'Usuário do PicPay',
                          ),
                        ),
                      ),
                    ],
                  )),
                  Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 40.0),
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
                          if (_formKey.currentState.validate()) {
                            Map<String, dynamic> userData = {
                              "name": _nameController.text,
                              "email": _emailController.text,
                              "birth": _birthController.text,
                              "picpay": _picpay.text,
                              "photoUrl": imageUrl,
                              "phone": _phone.text,
                              "conversou": [],
                              "fotos": [],
                            };

                            model.signUp(
                                userData: userData,
                                pass: _passController.text,
                                onSucess: _onSuccess,
                                onFail: _onFail);
                          }
                        },
                      ),
                    ),
                  ),
                ]),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
