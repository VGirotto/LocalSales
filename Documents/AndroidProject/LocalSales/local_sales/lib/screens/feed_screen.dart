import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/screens/cadastroProduto_screen.dart';
import 'package:local_sales/tabs/aboutapp_tab.dart';
import 'package:local_sales/tabs/configuration_tab.dart';
import 'package:local_sales/tabs/home_tab.dart';
import 'package:local_sales/tabs/log_tab.dart';
import 'package:local_sales/tabs/products_tab.dart';
import 'package:local_sales/widgets/custom_drawer.dart';
import 'package:local_sales/screens/editProfile_screen.dart';
import 'package:local_sales/screens/perfil_screen.dart';
import 'package:local_sales/tabs/chat_main_tab.dart';
import 'package:scoped_model/scoped_model.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(
            body: HomeTab(), //
            drawer: CustomDrawer(_pageController),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                _showSimpleDialog();
              },
              child: Icon(Icons.add, color: Colors.orange),
              backgroundColor: Colors.white,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Categorias"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: ProductsTab(),
          ),
          Scaffold(
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
            drawer: CustomDrawer(_pageController),
            body: Perfil(), //
          ),
          Scaffold(
              appBar: AppBar(
                title: Text("Chat"),
                centerTitle: true,
              ),
              drawer: CustomDrawer(_pageController),
              body: ScopedModelDescendant<UserModel>(
                builder: (context, child, model) {
                  print("\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n \\\\\\\\\\\\\\\\\\\\\\\ \n \\\\\\\\\\\\\\\\\\\\\\\\\ \n ${model.firebaseUser.uid} \n \\\\\\\\\\\\\\\\\\\\\\\\\\\\ \n \\\\\\\\\\\\\\\\\\\\\n");
                  return chat_main(model.userData ,currentUserId: model.firebaseUser.uid, name: model.userData["name"]);
                },
              )
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Meus Produtos"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: ScopedModelDescendant<UserModel>(
              builder: (context, child, model){
                return LogTab(currentUserId: model.firebaseUser.uid,);
              }
            )
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Configurações"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: ConfigurationTab(),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text("Sobre o app"),
              centerTitle: true,
            ),
            drawer: CustomDrawer(_pageController),
            body: AboutAppTab(title: "Sobre o app"),
          ),
        ],
      ),
    );
  }

  _dismissDialog() {
    Navigator.pop(context);
  }

  void _showSimpleDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text(
              'Escolha a categoria para adicionar o produto:',
              textAlign: TextAlign.center,
            ),
            titlePadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 10.0),
            children: <Widget>[
              SimpleDialogOption(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cadastroProduto(
                                  categoriaID: "Calçados",
                                )));
                  },
                  child: new Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Calçados',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cadastroProduto(
                                  categoriaID: "Caronas",
                                )));
                  },
                  child: new Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Caronas',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cadastroProduto(
                                  categoriaID: "Doces",
                                )));
                  },
                  child: new Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Doces',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cadastroProduto(
                                  categoriaID: "Eletrônicos",
                                )));
                  },
                  child: new Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Eletrônicos',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cadastroProduto(
                                  categoriaID: "Roupas",
                                )));
                  },
                  child: new Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Roupas',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
              SimpleDialogOption(
                  onPressed: () {
                    _dismissDialog();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => cadastroProduto(
                                  categoriaID: "Salgados",
                                )));
                  },
                  child: new Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
                      'Salgados',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
            ],
          );
        });
  }
}