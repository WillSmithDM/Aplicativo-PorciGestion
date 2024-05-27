import 'package:app_tesis/data/Dashboard/parte1.dart';
import 'package:app_tesis/domain/repositories/dashboard_repository.dart';

class DashboardPresenter {
  final DashboardViewContract _view;
  final DashboardRepository _repository;
  DashboardPresenter(this._view) : _repository = DashboardRepositoryImpl();

  void cantDashboard(String idCamp) async {
    try {
      final data = await _repository.getDatosCant(idCamp);
      _view.onLoadParte1Complete(data);
    } catch (e) {
      _view.onLoadParte1Error();
    }
  }

  void horizontalDash(String idCamp) async {
    try {
      final datah = await _repository.getDatoshorizontal(idCamp);
      _view.onLoadParte2Complete(datah);
    } catch (e) {
      _view.onLoadParte2Error();
    }
  }

  void vaccinesPend(String idCamp) async {
    try {
      final data3 = await _repository.getVaccinesDash(idCamp);
      _view.onLoadParte3Complete(data3);
    } catch (e) {
      _view.onLoadParte3Error();
    }
  }

  void updatePendi(String idcamp, String idpig, String idvac) async {
    try {
      await _repository.updatePendientes(idcamp, idpig, idvac);
      _view.onUpdateVacComplete();
    } catch (e) {
      _view.onUpdateVacError();
    }
  }
}

abstract class DashboardViewContract {
  void onLoadParte1Complete(List<dynamic> data);
  void onLoadParte1Error();
  void onLoadParte2Complete(List<dynamic> datah);
  void onLoadParte2Error();
  void onLoadParte3Complete(List<dynamic>data3);
  void onLoadParte3Error();
  void onUpdateVacComplete();
  void onUpdateVacError();
}
