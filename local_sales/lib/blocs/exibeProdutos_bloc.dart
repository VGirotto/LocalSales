import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria {least_expensive, alphabetical_order, insertion_data}

class ExibeProdutosBloc extends BlocBase {

  final _productsController = BehaviorSubject<List>();

  Stream<List> get outProducts => _productsController.stream;

  Map<String, Map<String, dynamic>> _produtos = {};

  Firestore _firestore = Firestore.instance;

  SortCriteria _criteria;

  ExibeProdutosBloc() {
    _addProductListener();
  }

  void setOrderCriteria(SortCriteria criteria){
    _criteria = criteria;
    _sort();
  }

  void _sort(){
    switch(_criteria){
      case SortCriteria.least_expensive:
        print('ola');
        _produtos.values.toList().sort((a,b){ ///erro aqui na minha opiniao
          double pa = a["price"];
          double pb = b["price"];
          if (pa < pb) return 1;
          else if (pa > pb) return -1;
          else return 0;
        });
        break;
      case SortCriteria.insertion_data:
        break;
      case SortCriteria.alphabetical_order:
        break;
    }
    _productsController.add(_produtos.values.toList());
  }

  void onChangedSearch(String search) {
    if (search
        .trim()
        .isEmpty) {
      _productsController.add(_produtos.values.toList());
    } else {
      _productsController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search) {
    List<Map<String, dynamic>> filteredUsers = List.from(
        _produtos.values.toList());

    filteredUsers.retainWhere((product) {
      return product["title"].toUpperCase().contains(search.toUpperCase());
    });

    return filteredUsers;
  }

  void _addProductListener() {
    _firestore.collection("Produtos").document("Todos")
        .collection("itens")
        .snapshots()
        .listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String pid = change.document.documentID;

        switch (change.type) {
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
      _sort();
    });
  }

  @override
  void dispose() {
    _productsController.close();
  }
}
