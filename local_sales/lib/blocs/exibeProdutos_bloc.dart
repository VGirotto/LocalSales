import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

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
            _productsController.add(_produtos.entries.toList());
            break;
          case DocumentChangeType.removed:
            _produtos.remove(pid);
            _productsController.add(_produtos.entries.toList());
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