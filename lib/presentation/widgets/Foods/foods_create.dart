import 'package:app_tesis/domain/models/foods/foods_form.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class CreateFoods extends StatefulWidget {
  const CreateFoods({super.key});

  @override
  State<CreateFoods> createState() => _CreateFoodsState();
}

class _CreateFoodsState extends State<CreateFoods>
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
      appBar: AppBarWidget.appBar('Nuevo Registro'),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FoodsForm(
          isEditing: false,
          onSubmit: (data, isEditing) async {
            if (!isEditing) {
              if (mounted) {
                AlertMessages.showConfirmation(
                    context, 'REGISTRO', 'Desea realizar este Registro?',
                    () async {
                  _presenter.insert(campaingID, data);
                });
              }
            }
          },
        ),
      ),
    );
  }

  @override
  void onFoodsInsertComplete(message) {
    if (message == 'success') {
      AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
      Navigator.pop(context);
      _presenter.loadFoods(campaingID);
    } else if (message == 'duplicado') {
      AlertMessages.alertInfo(context, "Registro Existente!");
    }
  }

  @override
  void onFoodsInsertError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

  @override
  void onFoodsUpdateComplete(message) {}
  @override
  void onFoodsUpdateError() {}
  @override
  void onLoadFoodsComplete(List data) {}
  @override
  void onLoadFoodsError() {}
  @override
  void onFoodsDeleteComplete(message) {}
  @override
  void onFoodsDeleteError() {}
}
