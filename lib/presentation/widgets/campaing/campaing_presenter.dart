import 'package:app_tesis/data/campaing/campaing_data.dart';
import 'package:app_tesis/domain/repositories/campaing_repository.dart';

class CampaingPresenter {
  final CampaingViewContract _view;
  final CampaingRepository _repository;

  CampaingPresenter(this._view) : _repository = CampaingRepositoryImpl();

  void loadCampaings() async {
    try {
      final userdata = await _repository.getCampaings();
      _view.onLoadCampaingsComplete(userdata);
    } catch (e) {
      _view.onLoadCampaingsError();
    }
  }

  void deleteCampaing(String id) async {
    try {
      String message = await _repository.deleteCampaing(id);
      _view.onCampaingDeleteComplete(message);
    } catch (e) {
      _view.onCampaingDeleteError();
    }
  }

  void createCampaing(
      Map<String, dynamic> data, DateTime startDate, DateTime endDate) async {
    try {
      String message = await _repository.insertCampaing(data, startDate, endDate);
      _view.onCampaingCreationComplete(message);
    } catch (e) {
      _view.onCampaingCreationError();
    }
  }

  void updateCampaing(Map<String, dynamic> data, DateTime startDate,
      DateTime endDate, String id) async {
    try {
      String message = await _repository.updateCampaing(data, startDate, endDate, id);
      _view.onCampaingUpdateComplete(message);
    } catch (e) {
      _view.onCampaingUpdateError();
    }
  }
}

abstract class CampaingViewContract {
  void onLoadCampaingsComplete(List<dynamic>  userdata);
  void onLoadCampaingsError();
  void onCampaingCreationComplete(String message);
  void onCampaingCreationError();
  void onCampaingUpdateComplete(String message);
  void onCampaingUpdateError();
  void onCampaingDeleteComplete(String message);
  void onCampaingDeleteError();
}
