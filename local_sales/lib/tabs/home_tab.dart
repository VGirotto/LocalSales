import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

    Widget _buildFloating(){
      return SpeedDial(
        child: Icon(Icons.sort, color: Colors.orange),
        backgroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.6,
        children: [
          SpeedDialChild(
            child: Icon(Icons.arrow_downward, color: Colors.orange),
            backgroundColor: Colors.white,
            label: "Menor preço",
            labelStyle: TextStyle(fontSize: 14),
            onTap: _exibeProdutosBloc.onTappedMenor/*{
              print("oi");
              _exibeprodutos.setOrderCriteria(SortCriteria.least_expensive);
            }*/
          ),
          SpeedDialChild(
            child: Icon(Icons.reorder, color: Colors.orange),
            backgroundColor: Colors.white,
            label: "Ordem alfabética",
            labelStyle: TextStyle(fontSize: 14),
            onTap: (){
              //_exibeprodutos.setOrderCriteria(SortCriteria.alphabetical_order);
            }
          ),
          SpeedDialChild(
            child: Icon(Icons.calendar_today, color: Colors.orange),
            backgroundColor: Colors.white,
            label: "Últimos adicionados",
            labelStyle: TextStyle(fontSize: 14),
            onTap: (){
              //_exibeprodutos.setOrderCriteria(SortCriteria.insertion_data);
            }
          ),
        ],
      );
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
              floatingActionButton: _buildFloating(),
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