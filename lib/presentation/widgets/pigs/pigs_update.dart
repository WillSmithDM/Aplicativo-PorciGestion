import 'package:app_tesis/domain/models/pigs/pigs_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class UpdatePigs extends StatefulWidget {
  final String id;
  final String codigo;
  final String peso;
  final String coste;
  const UpdatePigs(
      {super.key,
      required this.id,
      required this.codigo,
      required this.peso,
      required this.coste});

  @override
  State<UpdatePigs> createState() => _UpdatePigsState();
}

class _UpdatePigsState extends State<UpdatePigs> implements PigsViewContract {
  late PigsPresenter _presenter;
  String idCamp = CampaingId.id!;

  @override
  void initState() {
    super.initState();
    _presenter = PigsPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      appBar: AppBar(
        title: const Text(
          'Nuevo registro',
          style: TextStyle(color: MisColores.blanco),
        ),
        backgroundColor: MisColores.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FormPigs(
          initialCod: widget.codigo,
          initialCoste: widget.coste,
          initialPesoI: widget.peso,
          isEditing: true,
          onSubmit: (data, isEditing) async {
            if (isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(context, "Actualizar Porcino",
                    "Desea actualizar este registro?", () async {
                  _presenter.updatPigs(idCamp, widget.id, data, );
                });
              }
            }
            
          },
        ),
      ),
    );
  }


  @override
  void onPigsUpdateError() {
 AlertMessages.alertErrors(context, Messages().messageUpdateError);
  }
  @override
  void onPigsUpdateComplete() {
       AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
  Navigator.pop(context, 'refresh');
    _presenter.loadPigs(idCamp);
    
    }

  //MANTENER VACIOS ESTOS DE ACA ABAJO, NO TIENEN RELEVANCIA PERO DEBEN LLAMARSE ↓
  @override
  void onLoadPigsComplete(List userdata) {}
  @override
  void onLoadPigsError() {}
  @override
  void onPigsCreateComplete(message) {}
  @override
  void onPigsCreateError() {}
  @override
  void onPigsDeleteComplete(message) {}
  @override
  void onPigsDeleteError() {}
}
