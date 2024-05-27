import 'package:app_tesis/data/Users/user_data.dart';
import 'package:app_tesis/domain/repositories/user_repository.dart';

class UserPresenter {
  final UserViewContract _view;
  final UsersRepository _repository;
  UserPresenter(this._view) : _repository = UserRepositoryImpl();

  void loadUser() async {
    try {
      final List<dynamic> data = await _repository.getUser();
      _view.oninicioComplete(data);
    } catch (e) {
      _view.oninicioError();
    }
  }
  void inicio(String id) async {
    try {
      final data = await _repository.getUserID(id);
      _view.onLoadComplete(data);
    } catch (e) {
      _view.onLoadError();
    }
  }

  void insertUser(data) async {
    try {
      String message = await _repository.insertUsers(data);
      _view.onInsertComplete(message);
    } catch (e) {
      _view.onInsertError();
    }
  }

  void updateUser(String id, data) async {
    try {
      String message = await _repository.updateUsers(id, data);
      _view.onUpdateComplete(message);
    } catch (e) {
      _view.onUpdateError();
    }
  }

  void deleteUser(String id) async {
    try {
      String message = await _repository.deleteUser(id);
      _view.onDeleteComplete(message);
    } catch (e) {
      _view.onDeleteError();
    }
  }
}

abstract class UserViewContract {
  void onLoadComplete(List<dynamic> data);
  void onLoadError();
  void oninicioComplete( List<dynamic> data);
  void oninicioError();
  void onInsertComplete(String message);
  void onInsertError();
  void onUpdateComplete(String message);
  void onUpdateError();
  void onDeleteComplete(String message);
  void onDeleteError();
}
