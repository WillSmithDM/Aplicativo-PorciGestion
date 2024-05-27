import 'package:app_tesis/data/weight_control/weight_control_data.dart';
import 'package:app_tesis/domain/repositories/controlpeso_repository.dart';

class ControlPresenter {
  final ControlViewContract _view;
  final ControlRepository _repository;

  ControlPresenter(this._view) : _repository = ControlRepositoryImpl();

  void loadControlG(String idCamp) async {
    try {
      final userdata = await _repository.getControlPesoG(idCamp);
      _view.onLoadControlComplete(userdata);
    } catch (e) {
      _view.onLoadControlError();
    }
  }

  void loadControlP(String idCamp, String idPorcino) async {
    try {
      final userdata = await _repository.getControlPesoP(idCamp, idPorcino);
      _view.onLoadControlComplete(userdata);
    } catch (e) {
      _view.onLoadControlError();
    }
  }

  void insertControl(
      data, String idCamp, String idPorcino) async {
    try {
     String message = await _repository.insertControl(data, idCamp, idPorcino);
      _view.onControlInsertComplete(message);
    } catch (e) {
      _view.onControlInsertError();
    }
  }

  void deleteControl(String id) async {
    try {
     String message = await _repository.deleteControl(id);
      _view.onControlDeleteComplete(message);
    } catch (e) {
      _view.onControlDeleteError();
    }
  }

  void updateControlPigs(String idCamp, String idPorcino, String id,
       data) async {
    try {
      String message = await _repository.updateControl(idCamp, idPorcino, id, data);
      _view.onControlUpdateSuccess(message);
    } catch (e) {
      _view.onControlUpdateError();
    }
  }
}

abstract class ControlViewContract {
  void onLoadControlComplete(List userdata);
  void onLoadControlError();
  void onControlInsertComplete(String message);
  void onControlInsertError();
  void onControlDeleteComplete(String message);
  void onControlDeleteError();
  void onControlUpdateSuccess(String message);
  void onControlUpdateError();
}
