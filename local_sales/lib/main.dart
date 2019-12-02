
import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:local_sales/screens/feed_screen.dart';

    //Pra que servem tantos códigos
    //se a vida não é programada e
    //as melhores coisas não tem lógica

    //De que adianta programar toda a vida
    //se o retorno dela
    //é sempre vazio

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
            title: 'Local Sales',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            debugShowCheckedModeBanner: false,
            home: ScopedModelDescendant<UserModel>(
              builder: (context, child, model){
                if(model.isLoggedIn())
                  return Feed();
                else
                  return Login();
              },
            ),
        ),
    );
  }
}

