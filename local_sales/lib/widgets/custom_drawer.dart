import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/screens/login_screen.dart';
import 'package:local_sales/widgets/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  
  final PageController pageController;

  CustomDrawer(this.pageController);
  
  @override
  Widget build(BuildContext context) {
    
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        color: Colors.white
      ),
    );
    
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom:8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        child: DecoratedBox(
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('images/Logo.png')
                            )
                          )
                        )
                      )
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          /* return Text(
                            "Olá, ${model.currentUser() == null ? "" : model.userData["name"]}!",
                            style: 
                              TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                          );*/
                          
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                            "Olá, ${model.currentUser() == null ? "" : model.userData["name"]}!",
                            style: 
                              TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                          ),
                              GestureDetector(
                                child: Text(
                                  model.isLoggedIn() ? "Sair" : "",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: (){
                                  model.signOut();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                                },
                              )
                            ],
                            );
                        }
                      )
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Categorias", pageController, 1),
              DrawerTile(Icons.account_circle, "Perfil", pageController, 2),
              DrawerTile(Icons.chat, "Chat", pageController, 3),
              DrawerTile(Icons.playlist_add_check, "Meus Produtos", pageController, 4),
              DrawerTile(Icons.settings, "Configurações", pageController, 5),
              DrawerTile(Icons.info_outline, "Sobre o app", pageController, 6),
            ],
          ),
        ]
      )
    );
  }
}