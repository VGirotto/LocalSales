import 'package:test/test.dart';
import 'package:local_sales/screens/login_screen.dart';

void main(){

  test('empty email retunrs error string', (){
      var result = EmailFieldValidator.validate('');
      expect(result, 'Email cannot be empty');
  });

  test('non-empty email returns null', (){
    var result = EmailFieldValidator.validate('E-mail:');
    expect(result, null);
  });


  test('empty password retunrs error string', (){
    var result = PasswordFieldValidator.validate('');
    expect(result, 'Password cannot be empty');
  });

  test('non-empty password returns null', (){
    var result = PasswordFieldValidator.validate('Senha:');
    expect(result, null);
  });

}