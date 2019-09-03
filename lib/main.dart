import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home: Home())
  );
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
        padding: EdgeInsets.only(left: 25.0, right: 25.0),
        children:<Widget>[
          Text('Sales Local', style: TextStyle(fontSize: 40), textAlign: TextAlign.center),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child:
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Usuario',
                prefixIcon: Icon(Icons.account_circle, size: 40, ),
              ),
            ),

          ),
          Container(
            padding: EdgeInsets.only(bottom: 50.0),
            child:
            TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(Icons.lock_outline, size: 40, )
                )
            ),
          ),

          Checkbox(//////////////////////
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                //labelText: 'Forma de pagamento',
                  prefixIcon: Icon(Icons.attach_money, size: 40, )
              )
          )



          //, style: TextStyle(color: Colors.white, fontSize: 40))//,
          //Text('Login', style: TextStyle(color: Colors.white,fontSize: 20, height: 10.0)),
          //Text('Senha', style: TextStyle(color: Colors.white,fontSize: 20, height: 5.0)),
          //Text('email', style: TextStyle(color: Colors.white, fontSize: 20, height: 5.0)),
          //Text('Informações pessoais', style: TextStyle(color: Colors.white, fontSize: 40, height:5.0)),
          //Text('Formas de pagametno', style: TextStyle(color: Colors.white,fontSize: 20, height: 5.0))





        ]
    )
    );}
}
