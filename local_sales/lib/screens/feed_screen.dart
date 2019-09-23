import 'package:flutter/material.dart';
import 'package:local_sales/tabs/aboutapp_tab.dart';
import 'package:local_sales/tabs/chat_tab.dart';
import 'package:local_sales/tabs/configuration_tab.dart';
import 'package:local_sales/tabs/home_tab.dart';
import 'package:local_sales/tabs/log_tab.dart';
import 'package:local_sales/tabs/products_tab.dart';
import 'package:local_sales/widgets/custom_drawer.dart';
//import 'package:local_sales/screens/login_screen.dart';
import 'package:local_sales/screens/perfil_screen.dart';

class Feed extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
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
          drawer: CustomDrawer(_pageController),
          body: Perfil(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Chat"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ChatTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Histórico"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: LogTab(),
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
          body: AboutAppTab(),
        ),

        //Perfil(),
        //TODO: Adicionar os outros filhos
      ],
    );

    /*return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              Text("Bem-vindo",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                  textAlign: TextAlign.center),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Perfil())
                  );
                },
                child: Text("Perfil",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    textAlign: TextAlign.center),
                color: Colors.orange,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: Text("Sair",
                    style: TextStyle(color: Colors.black, fontSize: 20.0),
                    textAlign: TextAlign.center)
              ),
            ]
          ),
        ),
      backgroundColor: Colors.white
    );*/
  }
}