import 'package:app_tesis/domain/models/pigs/pigs_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';


class CreatePigs extends StatefulWidget {
  const CreatePigs({super.key});

  @override
  State<CreatePigs> createState() => _CreatePigsState();
}

class _CreatePigsState extends State<CreatePigs> implements PigsViewContract {
  late PigsPresenter _presenter;
  String idCamp = CampaingId.id!;

  @override
  void initState() {
    _presenter = PigsPresenter(this);
    super.initState();
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
          isEditing: false,
          onSubmit: (data, isEditing) async {
            if (!isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(context, "Registrar Porcino",
                    "Desea Realizar este registro?", () async {
                  _presenter.insertPigs(idCamp, data);
                });
              }
            }
          },
        ),
      ),
    );
  }

  

  @override
  void onPigsCreateComplete(message) {
    if (message == "success") {
      
    AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
     Navigator.pop(context);
    _presenter.loadPigs(idCamp);
    }
  }

  @override
  void onPigsCreateError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }


//MANTENER VACIOS ESTOS DE ACA ABAJO, NO TIENEN RELEVANCIA PERO DEBEN LLAMARSE ↓
  @override
  void onPigsDeleteComplete(message) {}

  @override
  void onPigsDeleteError() {}
  
  @override
  void onPigsUpdateComplete() {}
  
  @override
  void onPigsUpdateError() {}

  @override
  void onLoadPigsComplete(List<dynamic> userdata) {}

  @override
  void onLoadPigsError() {}
}
