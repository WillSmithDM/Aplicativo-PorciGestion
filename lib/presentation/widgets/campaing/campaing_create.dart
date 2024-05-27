import 'package:app_tesis/domain/models/campaing/my_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/widgets/campaing/campaing_presenter.dart';

class CreateCampaing extends StatefulWidget {
  const CreateCampaing({Key? key}) : super(key: key);

  @override
  _CreateCampaingState createState() => _CreateCampaingState();
}

class _CreateCampaingState extends State<CreateCampaing>
    implements CampaingViewContract {
  late CampaingPresenter _presenter;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _presenter = CampaingPresenter(this);
    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      appBar: AppBar(
        title: const Text('Nuevo registro'),
        backgroundColor: MisColores.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: MyForm(
          isEditing: false,
          onSubmit: (data, isEditing) async {
            if (!isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(context, "Registrar Campaña",
                    'Desea realizar este registro?', () async {
                  _presenter.createCampaing(data, _startDate, _endDate);
                });
              }
            } else {
              // No es necesario confirmar la edición, se realiza directamente
              _presenter.createCampaing(data, _startDate, _endDate);
            }
          },
          onStartDateSelected: (date) {
            setState(() {
              _startDate = date;
            });
          },
          onEndDateSelected: (date) {
            setState(() {
              _endDate = date;
            });
          },
        ),
      ),
    );
  }

  @override
  void onCampaingCreationComplete(message) {
    if (message == "success") {
      AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
      Navigator.pop(context);
      _presenter.loadCampaings();
    }
  }

  @override
  void onCampaingCreationError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

  @override
  void onLoadCampaingsComplete(List<dynamic> userdata) {}

  @override
  void onCampaingUpdateComplete(message) {}

  @override
  void onCampaingUpdateError() {}

  @override
  void onLoadCampaingsError() {}

  @override
  void onCampaingDeleteComplete(String message) {
    // TODO: implement onCampaingDeleteComplete
  }

  @override
  void onCampaingDeleteError() {
    // TODO: implement onCampaingDeleteError
  }
}
