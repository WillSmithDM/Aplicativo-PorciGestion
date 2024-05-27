import 'package:app_tesis/data/Dashboard/parte1.dart';
import 'package:app_tesis/domain/models/vaccines/calendar_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/widgets/vaccines/vaccines_presenter.dart';

class CreateVaccines extends StatefulWidget {
  const CreateVaccines({super.key});

  @override
  State<CreateVaccines> createState() => _CreateVaccinesState();
}

class _CreateVaccinesState extends State<CreateVaccines>
    implements VaccinesViewContract {
  late VaccinesPresenter _presenter;
  String campaingId = CampaingId.id!;
  String pigsId = PigsGlobalKey.id!;
  @override
  void initState() {
    _presenter = VaccinesPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      appBar: AppBarWidget.appBar("Nuevo Registro"),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: CalendarForm(
          isEditing: false,
          onSubmit: (data, isEditing) async {
            if (!isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(
                    context, 'NUEVO REGISTRO', 'Desea realizar este registro?',
                    () async {
                  _presenter.insertVaccines(campaingId, pigsId, data);
                });
              }
            }
          },
        ),
      ),
    );
  }

  @override
  void onInsertComplete(message) {
    if (message == "success") {
      AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
      Navigator.pop(context);
      _presenter.listVaccines(campaingId, pigsId);
      DashboardRepositoryImpl().getVaccinesDash(campaingId);
    }
  }

  @override
  void onInsertError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

  //No se usan estos ↓
  @override
  void onDeleteComplete(message) {}
  @override
  void onDeleteError() {}
  @override
  void onLoadListComplete(List<dynamic> data) {}
  @override
  void onLoadListError() {}
  @override
  void onUpdateComplete(message) {}
  @override
  void onUpdateError() {}
}
