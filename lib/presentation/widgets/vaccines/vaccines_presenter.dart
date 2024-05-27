import 'package:app_tesis/data/vaccines/vaccines_data.dart';
import 'package:app_tesis/domain/repositories/vaccines_repository.dart';

class VaccinesPresenter {
  final VaccinesViewContract _view;
  final VaccinesRepository _repository;

  VaccinesPresenter(this._view) : _repository = VaccinesRepositoryImpl();
  void deleteVaccines(String id) async {
    try {
       String message =  await _repository.deleteVaccines(id);
      _view.onDeleteComplete(message);
    } catch (e) {
      _view.onDeleteError();
    }
  }

  void listVaccines(String idCamp, String idPigs) async {
    try {
      final data = await _repository.getVaccines(idCamp, idPigs);
      _view.onLoadListComplete(data);
    } catch (e) {
      _view.onLoadListError();
    }
  }

  void listVaccinesGeneral(String idCamp) async {
    try {
      final data = await _repository.getVaccinesGeneral(idCamp);
      _view.onLoadListComplete(data);
    } catch (e) {
      _view.onLoadListError();
    }
  }

  void insertVaccines(String idCamp, String idPigs, data) async {
    try {
      String message = await _repository.insertVaccines(idCamp, idPigs, data);
      _view.onInsertComplete(message);
    } catch (e) {
      _view.onInsertError();
    }
  }

  void updateVaccine(String id, data) async {
    try {
      String message = await _repository.updateVaccines(id, data);
      _view.onUpdateComplete(message);
    } catch (e) {
      _view.onUpdateError();
    }
  }
}

abstract class VaccinesViewContract {
  void onLoadListComplete(List< dynamic> data);
  void onLoadListError();
  void onDeleteComplete(String message);
  void onDeleteError();
  void onInsertComplete(String message);
  void onInsertError();
  void onUpdateComplete(String message);
  void onUpdateError();
}
