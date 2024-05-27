import 'package:app_tesis/data/Historial/historial_data.dart';
import 'package:app_tesis/domain/repositories/historial_repository.dart';

class HistorialPresenter {
  final HistorialViewContract _view;
  final HistorialRepository _repository;
  HistorialPresenter(this._view) : _repository = HistorialRepositoryImpl();

  void listPig(String idCamp) async {
    try {
      final data = await _repository.getPig(idCamp);
      _view.onLoadPigComplete(data);
    } catch (e) {
      _view.onLoadPigError();
    }
  }

  void listHistorial(String idCamp, String idPig) async {
    try {
      final datah = await _repository.getHistorialList(idCamp, idPig);
      _view.onLoadHistorialComplete(datah);
    } catch (e) {
      _view.onLoadHistorialError();
    }
  }

  void insertHistorial(String idcamp, String idPig, String idUser, data) async {
    try {
      String message =await _repository.insertHistorial(idcamp, idPig, idUser, data);
      _view.onInsertComplete(message);
    } catch (e) {
      _view.onInsertError();
    }
  }

  void infoHiistorial(String idCamp, String idPig, String id) async {
    try {
      final data3 = await _repository.getHistorial(idCamp, idPig, id);
      _view.onLoadinfoComplete(data3);
    } catch (e) {
      _view.onLoadinfoError();
    }
  }
}

abstract class HistorialViewContract {
  void onLoadPigComplete(List data);
  void onLoadPigError();
  void onLoadHistorialComplete(List datah);
  void onLoadHistorialError();
  void onLoadinfoComplete(List data3);
  void onLoadinfoError();
  void onInsertComplete(String message);
  void onInsertError();
}
