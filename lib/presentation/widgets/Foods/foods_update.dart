import 'package:app_tesis/domain/models/foods/foods_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';


class UpdateFoods extends StatefulWidget {
  final String id;
  final String nombre;
  final String cant;
  final String proveedor;
  final String precio;
  final String porcentaje;
  const UpdateFoods(
      {super.key,
      required this.nombre,
      required this.cant,
      required this.proveedor,
      required this.precio,
      required this.porcentaje, required this.id});

  @override
  State<UpdateFoods> createState() => _UpdateFoodsState();
}

class _UpdateFoodsState extends State<UpdateFoods>
    implements FoodsViewContract {
  late FoodsPresenter _presenter;
  String campaingID = CampaingId.id!;
  @override
  void initState() {
    _presenter = FoodsPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      appBar: AppBarWidget.appBar('Actualizar Registro'),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FoodsForm(
          cantidad: widget.cant,
          initialnombre: widget.nombre,
          peso: widget.proveedor,
          porcentaje: widget.porcentaje,
          precio: widget.precio,
          isEditing: true,
          onSubmit: (data, isEditing) async {
            if (isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(
                    context,
                    'ACTUALIZACIÓN DE DATOS',
                    'Desea actualizar este Registro?', () async {
                  _presenter.update(widget.id,campaingID, data);
                });
              }
            }
          },
        ),
      ),
    );
  }
    @override
  void onFoodsUpdateComplete(message) {
    if (message == "success") {
      
    }
       AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
    Navigator.pop(context);
    _presenter.loadFoods(campaingID);
  }
  @override
  void onFoodsUpdateError() {
     AlertMessages.alertErrors(context, Messages().messageUpdateError);
  }


  @override
  void onFoodsDeleteComplete(message) {}
  @override
  void onFoodsDeleteError() {}
  @override
  void onFoodsInsertComplete(message) {}
  @override
  void onFoodsInsertError() { }
  @override
  void onLoadFoodsComplete(List data) {}
  @override
  void onLoadFoodsError() {}
}
