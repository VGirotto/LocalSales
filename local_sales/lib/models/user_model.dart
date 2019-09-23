import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth
      .instance; //Cria variável que guarda a instância do FirebaseAuth

  FirebaseUser firebaseUser; //Declara uma variável do tipo FirebaseUser
  Map<String, dynamic> userData =
      Map(); //Um map que guarda dois valores. O setData do firebase recebe maps como paramêtros.

  bool isLoading = false;

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();


    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((auth) async {
      firebaseUser = auth.user;


      await _saveUserData(userData);



      onSucess();

      isLoading = false;
      notifyListeners();
    }).catchError((e) {

      print(e); //printa o erro para debug

      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signIn({@required String email,@required String pass,
    @required VoidCallback onSucess,@required VoidCallback onFail}) async {

    isLoading = true;
    notifyListeners();

   _auth.signInWithEmailAndPassword(email: email, password: pass).then((user){

     firebaseUser = user.user;

     onSucess();
     isLoading = false;
     notifyListeners();

   }).catchError((e){

     onFail();
     isLoading = false;
      notifyListeners();
   });

  }

  void recoverPass() {}

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await Firestore.instance
        .collection("Usuário")
        .document(firebaseUser.uid)
        .setData(userData);
  }
}
