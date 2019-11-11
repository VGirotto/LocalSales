
import 'package:flutter/material.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:local_sales/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:local_sales/screens/feed_screen.dart';

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

