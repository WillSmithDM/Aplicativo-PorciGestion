import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/domain/models/campaing/my_form.dart';
import 'package:app_tesis/presentation/widgets/campaing/campaing_presenter.dart';

class EditCampaing extends StatefulWidget {
  final String id;
  final String nombre;
  final String dateInicio;
  final String dateFin;
  final String est;

  const EditCampaing({
    super.key,
    required this.id,
    required this.nombre,
    required this.dateInicio,
    required this.dateFin,
    required this.est,
  });

  @override
  State<EditCampaing> createState() => _EditCampaingState();
}

class _EditCampaingState extends State<EditCampaing>
    implements CampaingViewContract {
  late CampaingPresenter _presenter;
  late DateTime _startDate;
  late DateTime _endDate;
  late String _status;

  @override
  void initState() {
    super.initState();
    _presenter = CampaingPresenter(this);
    _startDate = DateTime.parse(widget.dateInicio);
    _endDate = DateTime.parse(widget.dateFin);
    _status = widget.est == '1' ? 'Activo' : 'Culminar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      appBar: AppBar(
        title: const Text('Editar registro'),
        backgroundColor: MisColores.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: MyForm(
          onSubmit: (data, isEditing) async {
            if (isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(context, "Editar Datos",
                    "Seguro de editar los datos de este registro?", () async {
                  _presenter.updateCampaing(
                      data, _startDate, _endDate, widget.id);
                });
              }
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
          isEditing: true,
          initialStatus: _status,
          initialName: widget.nombre, // Pasa el nombre inicial al formulario
          initialStartDate:
              _startDate, // Pasa la fecha de inicio inicial al formulario
          initialEndDate:
              _endDate, // Pasa la fecha de fin inicial al formulario
        ),
      ),
    );
  }

  @override
  void onCampaingUpdateComplete(message) {
    if (message == "success") {
      AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
      Navigator.pop(context, 'refresh');
      _presenter.loadCampaings();
    }
  }

  @override
  void onCampaingUpdateError() {
    AlertMessages.alertErrors(context, Messages().messageUpdateError);
  }

  //MANTENER VACIOS ESTOS DE ACA ABAJO, NO TIENEN RELEVANCIA PERO DEBEN LLAMARSE ↓
  @override
  void onCampaingCreationComplete(message) {}

  @override
  void onCampaingCreationError() {}

  @override
  void onLoadCampaingsComplete(List<dynamic> userdata) {}

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
