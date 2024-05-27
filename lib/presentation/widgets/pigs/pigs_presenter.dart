import 'package:app_tesis/data/pigs/pigs_data.dart';
import 'package:app_tesis/domain/repositories/pigs_repository.dart';

class PigsPresenter {
  final PigsViewContract _view;
  final PigsRepository _repository;
  PigsPresenter(this._view) : _repository = PigsRepositoryImpl();

  void loadPigs(String idCamp) async {
    try {
      final userdata = await _repository.getPigs(idCamp);
      _view.onLoadPigsComplete(userdata);
    } catch (e) {
      _view.onLoadPigsError();
    }
  }

  void deletePigs(String id) async {
    try {
      String message = await _repository.deletePigs(id);
      _view.onPigsDeleteComplete(message);
    } catch (e) {
      _view.onPigsDeleteError();
    }
  }

  void insertPigs(String idCamp, Map<String, dynamic> data) async {
    try {
      String message = await _repository.insertPigs(idCamp, data);
      _view.onPigsCreateComplete(message);
    } catch (e) {
      _view.onPigsCreateError();
    }
  }

  void updatPigs(String idCamp, String id, Map<String, dynamic> data) async {
    try {
      await _repository.updatePigs(idCamp,id,data);
      _view.onPigsUpdateComplete();
    } catch (e) {
      _view.onPigsUpdateError();
    }
  }
}

abstract class PigsViewContract {
  void onLoadPigsComplete(List<dynamic>  userdata);
  void onLoadPigsError();
  void onPigsCreateComplete(String message);
  void onPigsCreateError();
  void onPigsDeleteComplete(String message);
  void onPigsDeleteError();
  void onPigsUpdateComplete();
  void onPigsUpdateError();
}
