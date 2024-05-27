import 'package:app_tesis/data/login_data.dart';
import 'package:app_tesis/domain/repositories/login_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class LoginPresenter {
  final LoginViewContract _view;
  final LoginRepository _repository;

  LoginPresenter(this._view) : _repository = LoginRepositoryImpl();

  void login(String username, String password) async {
  try {
    final Map<String, dynamic> loginResult = await _repository.login(username, password);

    if (loginResult.containsKey('token') && loginResult.containsKey('userData')) {
      //final String token = loginResult['token'];
      final Map<String, dynamic> userData = loginResult['userData'];

      final String userId = userData['id'].toString();
      final String rolId = userData['rol_id'].toString();
      final String Uname = userData['name'].toString();

      _view.onLoadLoginComplete(userId, rolId, Messages().messageLoginSucces, Uname);
    } else {
      _view.onLoadLoginError(Messages().messageDatIncorrec);
    }
  } catch (e) {
    _view.onLoadLoginError(Messages().errorConnect);
  }
}

}

abstract class LoginViewContract {
  void onLoadLoginComplete(String id, String idrol, String message, String name);
  void onLoadLoginError(String message);
}
