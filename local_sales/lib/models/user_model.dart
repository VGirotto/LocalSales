import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  bool isLoading = false;

  void signUp() async{
    isLoading = true;
    notifyListeners();
    
    await Future.delayed(Duration(seconds: 2));

    isLoading = false;
    notifyListeners();

  }

  void signIn(){

  }

  void recoverPass(){

  }



}