import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

class cadastroProduto extends StatefulWidget {
  @override
  _cadastroProdutoState createState() => _cadastroProdutoState();
}

class _cadastroProdutoState extends State<cadastroProduto> {

  final _nomeProdutoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _precoController = TextEditingController();
  final _categoriaController = TextEditingController();
  final _qtdController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastre seu produto', style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body:/* ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
      if (model.isLoading)
      return Center(
      child: CircularProgressIndicator(),
      );

      return*/ Form(
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
                                      fit: BoxFit.fill,
                                      image: AssetImage("images/Logo.png")
                                  )
                              )
                          )
                      )
                  ),
                  Container(
                      child: new TextFormField(
                        controller: _nomeProdutoController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(15),
                        ],
                        decoration: new InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          labelText: "Nome do produto:",
                          prefixIcon: Icon(
                            Icons.add_shopping_cart,
                            size: 40,
                            color: Colors.orange,
                          ),
                        ),
                        validator: (text) {
                          if (text.isEmpty) // adicionar mais condições de nome
                            return "Coloque um nome válido";
                        },
                      )),
                  Container(
                    child: new TextFormField(
                      controller: _descricaoController,
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Descrição:",
                        /* prefixIcon: Icon(
                      Icons., ENCONTRAR UM ICONE DAORA
                      size: 30,
                      color: Colors.orange,
                    ),*/
                      ),
                      validator: (text) {
                        if (text.isEmpty) // adicionar mais condições de descrição
                          return "Coloque uma descrição válida";
                      },
                    ),
                  ),
                  Container(
                    child: new TextFormField(
                      controller: _precoController,
                      keyboardType: TextInputType.number, // Arrumar um jeito de poder colocar numeros com virgula
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Preço:",
                        /* prefixIcon: Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                            color: Colors.orange,
                          ),*/
                      ),
                      validator: (text) {
                        if (text.isEmpty) // adicionar condições de preço
                          return "Coloque um preço válido";
                      },
                    ),
                  ),
                  Container(
                    child: new TextFormField(
                      controller: _qtdController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Quantidade disponível:",
                        /* prefixIcon: Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                            color: Colors.orange,
                          ),*/
                      ),
                      validator: (text) {
                        if (text.isEmpty) // adicionar condições de preço
                          return "Coloque uma quantidade válida";
                      },
                    ),
                  ),
                  Container(
                    child: new TextFormField(
                      controller: _categoriaController,
                      decoration: new InputDecoration(
                        labelStyle: TextStyle(color: Colors.black),
                        labelText: "Categoria:",
                        /* prefixIcon: Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                            color: Colors.orange,
                          ),*/
                      ),
                      validator: (text) {
                        if (text.isEmpty) // adicionar condições de preço
                          return "Coloque uma categoria válida";
                      },
                    ),
                  ),
                ]
            )
        )
    );
  }
}

