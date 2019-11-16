import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

//enum SortCriteria {least_expensive, alphabetical_order, insertion_data}

class ExibeProdutosBloc extends BlocBase{
  
  final _productsController = BehaviorSubject<List>();

  Stream<List> get outProducts => _productsController.stream;
  
  Map<String, Map<String, dynamic>> _produtos = {};

  Firestore _firestore = Firestore.instance;

  ExibeProdutosBloc(){
    _addProductListener();
  }

  void onChangedSearch(String search){
    if(search.trim().isEmpty){
      _productsController.add(_produtos.values.toList());
    }else{
      _productsController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search){
    List<Map<String, dynamic>> filteredUsers = List.from(_produtos.values.toList());

    filteredUsers.retainWhere((product){
      return product["title"].toUpperCase().contains(search.toUpperCase()); 
    });

    return filteredUsers;
  }

  void onTappedMenor(){
    _productsController.add(_menorPreco());
  }

  List<Map<String, dynamic>> _menorPreco(){
    List<Map<String, dynamic>> menorPreco = List.from(_produtos.values.toList());

    menorPreco.sort((a,b){
      double pa = a["price"];
      double pb = b["price"];
      if (pa > pb) return 1;
      else if (pa < pb) return -1;
      else return 0;
    });

    return menorPreco;
  }

  void _addProductListener(){
    _firestore.collection("Produtos").document("Todos").collection("itens").snapshots().listen((snapshot){
      snapshot.documentChanges.forEach((change){
        String pid = change.document.documentID;

        switch(change.type){
          case DocumentChangeType.added:
            _produtos[pid] = change.document.data;
            _productsController.add(_produtos.values.toList());
            break;
          case DocumentChangeType.modified:
            _produtos[pid].addAll(change.document.data);
            _productsController.add(_produtos.values.toList());
            break;
          case DocumentChangeType.removed:
            _produtos.remove(pid);
            _productsController.add(_produtos.values.toList());
            break;
        } 
      });
    });
  }

  @override
  void dispose() {
    _productsController.close();
  }
}