import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_sales/blocs/exibeProdutos_bloc.dart';
import 'package:local_sales/datas/product_data.dart';
import 'package:local_sales/widgets/product_tile.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab>{
  Icon _icone = new Icon(Icons.search);
  Widget _tituloAppBar = new Text( 'Produtos' );
  ExibeProdutosBloc _exibeProdutosBloc;

  @override
  void initState(){
    super.initState();
    _exibeProdutosBloc = ExibeProdutosBloc();
  }

  @override
  Widget build(BuildContext context) {

    void _searchPressed(){
      setState((){
        if(this._icone.icon == Icons.search){
          this._icone = new Icon(Icons.close);
          this._tituloAppBar = new TextField(
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search),
              hintText: 'Pesquisa...'
            ),
            onChanged: _exibeProdutosBloc.onChangedSearch
          );
        }else{
          this._icone = new Icon(Icons.search);
          this._tituloAppBar = new Text("Produtos");
        }
      });
    }

    return
      Stack(
        children: <Widget>[
          DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                leading: Container(color: Colors.orange),
                actions: <Widget>[
                  IconButton(
                    icon: _icone,
                    onPressed: (){
                      if(this._icone.icon == Icons.search){
                        _searchPressed();
                      }else{
                        _exibeProdutosBloc.onChangedSearch("");
                        _searchPressed();
                      }
                    },  
                  )
                ],
                title: _tituloAppBar,
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.grid_on,),),
                    Tab(icon: Icon(Icons.list,),),
                  ],
                ),
              ),
              body: BlocProvider<ExibeProdutosBloc>(
                bloc: _exibeProdutosBloc,
                child: StreamBuilder<List>(
                  stream: _exibeProdutosBloc.outProducts,
                  builder: (context, snapshot){
                    if(!snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
                    else if(snapshot.data.length == 0)
                      return Center(
                        child: Text("Nenhum produto encontrado...")
                      );
                    else
                      return TabBarView(
                        children: [
                          GridView.builder(
                            padding: EdgeInsets.all(4.0),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.61,
                            ),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return ProductTile("grid", ProductData.fromDocument(snapshot.data[index]), 0, snapshot.data[index]);
                            },
                          ),
                          ListView.builder(
                            padding: EdgeInsets.all(4.0),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return ProductTile("list", ProductData.fromDocument(snapshot.data[index]), 0, snapshot.data[index]);
                            }
                          ),
                        ],
                      );
                  }
                )
              )
            ),
          ),
          Container(
            height:110,
            width:110,
            child:CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      );
    //onRefresh: refresh;
  }
}

