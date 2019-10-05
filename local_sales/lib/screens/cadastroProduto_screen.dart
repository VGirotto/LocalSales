import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/blocs/product_bloc.dart';
import 'package:local_sales/validators/produto_validator.dart';
import 'package:local_sales/widgets/Images_widgets.dart';


class cadastroProduto extends StatefulWidget {

 final String categoriaID;
 final DocumentSnapshot product;

 cadastroProduto({this.categoriaID, this.product});

  @override
  _cadastroProdutoState createState() => _cadastroProdutoState(categoriaID, product);
}

class _cadastroProdutoState extends State<cadastroProduto> with ProductValidator{
  final ProductBloc _productBloc;
  final _formKey = GlobalKey<FormState>();

  _cadastroProdutoState(String categoriaID, DocumentSnapshot product):
        _productBloc = ProductBloc(categoriaID: categoriaID, product: product);

  @override
  Widget build(BuildContext context) {

    final _fieldStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
    );

    InputDecoration _buildDecoration(String label){
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey)
      );

    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text('Anunciar produto', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){},
          ),
        ]
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
          stream: _productBloc.outData,
          builder: (context, snapshot){
            if (!snapshot.hasData) return Container();
            return ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Text("Fotos:",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                ImagesWidget(
                  context: context,
                  initialValue: snapshot.data["images"],
                  onSaved: (l){},
                  validator: (l){},
                ),
                TextFormField(
                  initialValue: snapshot.data["title"],
                  style: _fieldStyle,
                  decoration: _buildDecoration("Nome"),
                  onSaved: (t){},
                  validator: (t){},
                ),
                TextFormField(
                  initialValue: snapshot.data["description"],
                  style: _fieldStyle,
                  maxLines: 6,
                  decoration: _buildDecoration("Descrição"),
                  onSaved: (t){},
                  validator: (t){},
                ),
                TextFormField(
                  initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                  style: _fieldStyle,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: _buildDecoration("Preço"),
                  onSaved: (t){},
                  validator: (t){},
               ),
                TextFormField(
                  initialValue: snapshot.data["amount"]?.toStringAsFixed(2),
                  style: _fieldStyle,
                  keyboardType: TextInputType.number,
                  decoration: _buildDecoration("Quantidade"),
                  onSaved: (t){},
                  validator: (t){},
                ),
              ],
          );
          }

        ),
      ),
    );

  }
}
