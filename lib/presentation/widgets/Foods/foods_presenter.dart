import 'package:app_tesis/data/Alimentos/alimentos_data.dart';
import 'package:app_tesis/domain/repositories/alimentos_repository.dart';

class FoodsPresenter {
  final FoodsViewContract _view;
  final AlimentosRepository _repository;

  FoodsPresenter(this._view) : _repository = AlimentosRepositoryImpl();

  void loadFoods(String idCamp) async {
    try {
      final data = await _repository.getAlimentos(idCamp);
      _view.onLoadFoodsComplete(data);
    } catch (e) {
      _view.onLoadFoodsError();
    }
  }

  void insert(String idCamp, data) async {
    try {
     String message = await _repository.insertAlimentos(idCamp, data);
     
      _view.onFoodsInsertComplete(message);
    } catch (e) {
      _view.onFoodsInsertError();
    }
  }

  void update(String id, String idCamp, data) async {
    try {
      String message = await _repository.updateAlimentos(id, idCamp, data);
      _view.onFoodsUpdateComplete(message);
    } catch (e) {
      _view.onFoodsUpdateError();
    }
  }

  void delete(String id) async {
    try {
      String message = await _repository.deleteAlimentos(id);
      _view.onFoodsDeleteComplete(message);
    } catch (e) {
      _view.onFoodsDeleteError();
    }
  }
}

abstract class FoodsViewContract {
  void onLoadFoodsComplete(List< dynamic> data);
  void onLoadFoodsError();
  void onFoodsInsertComplete(String message);
  void onFoodsInsertError();
  void onFoodsUpdateComplete(String mesage);
  void onFoodsUpdateError();
  void onFoodsDeleteComplete(String message);
  void onFoodsDeleteError();
}
