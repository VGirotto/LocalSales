import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth
      .instance; //Cria variável que guarda a instância do FirebaseAuth

  FirebaseUser firebaseUser; //Declara uma variável do tipo FirebaseUser
  Map<String, dynamic> userData =
      Map(); //Um map que guarda dois valores. O setData do firebase recebe maps como paramêtros.

  bool isLoading = false;

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _loadCurrentUser();
  }

  Future<FirebaseUser> currentUser() async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null)
      return user;
    else
      return null;
  }

  void update_base({@required Map<String, dynamic> userData}) async {
    firebaseUser = await currentUser();
    await _saveUserData(userData);
  }

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

      try {
        await firebaseUser.sendEmailVerification();
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
      }

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

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSucess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    //if (!firebaseUser.isEmailVerified) return null;

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user.user;

      await _loadCurrentUser();

      onSucess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;

    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);

    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .updateData({"id": firebaseUser.uid});

    print("entrou aqui");
  }

  Future<Null> loadUserData() async {
    DocumentSnapshot docUser = await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .get();
    userData = docUser.data;
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();

    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

  void saveName(String text) {
    userData["name"] = text;
  }

  void saveEmail(String text) {
    userData["email"] = text;
  }

  void saveBirth(String text) {
    userData["birth"] = text;
  }

  void savePhone(String text) {
    userData["phone"] = text;
  }

  void savePicpay(String text) {
    userData["picpay"] = text;
  }
}
