import 'package:app_tesis/domain/models/vaccines/calendar_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/widgets/vaccines/vaccines_presenter.dart';


class UpdateVacciness extends StatefulWidget {
  final String id;
  final String nVacines;
  final String fechaVaccines;
  late final DateTime fecha;
  UpdateVacciness(
      {super.key,
      required this.id,
      required this.nVacines,
      required this.fechaVaccines}) {
    fecha = DateTime.parse(fechaVaccines);
  }

  @override
  State<UpdateVacciness> createState() => _UpdateVaccinessState();
}

class _UpdateVaccinessState extends State<UpdateVacciness>
    implements VaccinesViewContract {
  late VaccinesPresenter _presenter;

  @override
  void initState() {
    _presenter = VaccinesPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      appBar: AppBarWidget.appBar("Editar Registro"),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: CalendarForm(
          isEditing: true,
          inititialName: widget.nVacines,
          initialDate: widget.fecha,
          onSubmit: (data, isEditing) async {
            if (isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(
                    context, 'EDITAR REGISTRO', 'Desea editar este registro?',
                    () async {
                  _presenter.updateVaccine(widget.id, data);
                });
              }
            }
          },
        ),
      ),
    );
  }

  @override
  void onUpdateComplete(message) {
    if (message == "success") {
      
AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
    Navigator.pop(context, 'refresh');
    _presenter.listVaccines(CampaingId.id!, PigsGlobalKey.id!); 
    }
     }

  @override
  void onUpdateError() {
  AlertMessages.alertErrors(context, Messages().messageUpdateError);
    Navigator.pop(context, 'refresh');
   }


   
  @override
  void onDeleteComplete(message) {}
  @override
  void onDeleteError() {}
  @override
  void onInsertComplete(message) {}
  @override
  void onInsertError() {}
  @override
  void onLoadListComplete(List<dynamic> data) {}
  @override
  void onLoadListError() {}

}
