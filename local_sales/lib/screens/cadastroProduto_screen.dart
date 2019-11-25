import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/blocs/product_bloc.dart';
import 'package:local_sales/validators/produto_validator.dart';
import 'package:local_sales/widgets/Images_widgets.dart';
import 'package:local_sales/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';


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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final String categoriaID;


  _cadastroProdutoState(this.categoriaID, DocumentSnapshot product):
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: StreamBuilder<bool>(
          stream: _productBloc.outCreated,
          initialData: false,
          builder: (context, snapshot) {
            return Text(snapshot.data ? "Editar Produto" : "Criar Produto", style: TextStyle(color: Colors.white));
          }
        ),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot){
              if(snapshot.data)
                return StreamBuilder<bool>(
                    stream: _productBloc.outLoading,
                    initialData: false,
                    builder: (context, snapshot) {
                      return IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: snapshot.data ? null : (){
                          _productBloc.deleteProduct();
                          Navigator.of(context).pop();
                        },
                      );
                    }
                );
              else return Container();
            },

          ),
          StreamBuilder<bool>(
            stream: _productBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(Icons.save),
                onPressed: snapshot.data ? null : saveProduct,
              );
            }
          ),
        ]
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          _productBloc.saveVendedor(model.userData["name"]);
          _productBloc.saveUid(model.firebaseUser.uid);
          _productBloc.saveCategoria(categoriaID);
          return Stack(
            children: <Widget>[
              Form(
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
                          onSaved: _productBloc.saveImages,
                          validator: validateImages,
                        ),
                        TextFormField(
                          initialValue: snapshot.data["title"],
                          style: _fieldStyle,
                          decoration: _buildDecoration("Nome"),
                          onSaved: _productBloc.saveTitle,
                          validator: validateTitle,
                        ),
                        TextFormField(
                          initialValue: snapshot.data["description"],
                          style: _fieldStyle,
                          maxLines: 6,
                          decoration: _buildDecoration("Descrição"),
                          onSaved: _productBloc.saveDescription,
                          validator: validateDescription,
                        ),
                        TextFormField(
                          initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                          style: _fieldStyle,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: _buildDecoration("Preço"),
                          onSaved: _productBloc.savePrice,
                          validator: validatePrice,
                      ),
                        TextFormField(
                          initialValue: snapshot.data["amount"]?.toString(),
                          style: _fieldStyle,
                          keyboardType: TextInputType.number,
                          decoration: _buildDecoration("Quantidade"),
                          onSaved: _productBloc.saveAmount,
                          validator: validateAmount,
                        ),
                      ],
                  );
                  }

                ),
              ),
              StreamBuilder<bool>(
                  stream: _productBloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return IgnorePointer(
                      ignoring: !snapshot.data,
                      child: Container(
                        color: snapshot.data ? Colors.black54 : Colors.transparent,
                      ),
                    );
                  }
              ),
            ],
          );
        },
      ),
    );
  }

  void saveProduct() async {
    if( _formKey.currentState.validate()){
      _formKey.currentState.save();



      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Salvando produto...", style: TextStyle(color: Colors.white),),
          duration: Duration(minutes: 1),
          backgroundColor: Colors.orangeAccent,
        )
      );

      

      bool success = await _productBloc.saveProduct();
      _scaffoldKey.currentState.removeCurrentSnackBar();

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(success? "Produto salvo!" : "Erro ao salvar produto!", style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.orangeAccent,
          )
      );

    }
  }

}
