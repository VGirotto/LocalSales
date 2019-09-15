import 'package:flutter/material.dart';
import 'package:local_sales/tabs/home_tab.dart';
import 'package:local_sales/widgets/custom_drawer.dart';
//import 'package:local_sales/screens/login_screen.dart';
//import 'package:local_sales/screens/perfil_screen.dart';

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
          drawer: CustomDrawer(),
        ),
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