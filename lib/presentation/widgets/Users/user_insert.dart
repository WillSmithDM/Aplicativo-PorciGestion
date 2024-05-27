import 'package:app_tesis/domain/models/users/form_user.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> implements UserViewContract {
  late UserPresenter _presenter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _presenter = UserPresenter(this);
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.fondo,
      appBar: AppBarWidget.appBar('Nuevo Registro'),
      body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: UserForm(
            isEditing: false,
            onSubmit: (data, isEditing) async {
              if (!isEditing) {
                if (mounted) {
                  AlertMessages.showConfirmation(context, 'Registrar Usuario',
                      'Desea realizar este registro?', () async {
                    _presenter.insertUser(data);
                  });
                }
              }
            },
          )),
    );
  }

  @override
  void onInsertComplete(message) {
    if (message == 'success') {
      
    AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
    Navigator.pop(context);
    _presenter.loadUser();
    }
  }

  @override
  void onInsertError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

//MANTENER VACIOS ESTOS DE ACA ABAJO, NO TIENEN RELEVANCIA PERO DEBEN LLAMARSE ↓
  @override
  void onDeleteComplete(message) {}
  @override
  void onDeleteError() {}
  @override
  void onLoadComplete(  data) {}
  @override
  void onLoadError() {}
  @override
  void onUpdateComplete(message) {}
  @override
  void onUpdateError() {}
  @override
  void oninicioComplete( data) {}
  @override
  void oninicioError() {}
}
