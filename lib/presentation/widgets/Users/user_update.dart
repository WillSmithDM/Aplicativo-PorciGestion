import 'package:app_tesis/domain/models/users/form_user.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class UpdateUser extends StatefulWidget {
  final String id;
  final String name;
  final String firstname;
  final String dni;
  final String email;
  final String password;
  final String username;
  final String phone;
  final String rol;
  const UpdateUser(
      {super.key,
      required this.id,
      required this.name,
      required this.firstname,
      required this.dni,
      required this.email,
      required this.password,
      required this.username,
      required this.phone,
      required this.rol});

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> implements UserViewContract {
  late UserPresenter _presenter;
  late String _selectRol;
  @override
  void initState() {
    super.initState();
    _selectRol = widget.rol;
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
            initialEmail: widget.email,
            initialPass: widget.password,
            initialUsername: widget.username,
            initialdni: widget.dni,
            initialfirstname: widget.firstname,
            initialname: widget.name,
            initialphone: widget.phone,
            initialRol: _selectRol,
            isEditing: true,
            onSubmit: (data, isEditing) async {
              if (isEditing) {
                if (mounted) {
                  AlertMessages.showConfirmation(context, 'Actualizar Usuario',
                      'Desea actualizar este registro?', () async {
                    _presenter.updateUser(widget.id, data);
                  });
                }
              }
            },
          )),
    );
  }

  @override
  void onUpdateComplete(message) {
    if(message == "success"){
      
    AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
    Navigator.pop(context);
    _presenter.loadUser();
    }
  }

  @override
  void onUpdateError() {
    AlertMessages.alertErrors(context, Messages().messageUpdateError);
  }

//MANTENER VACIOS ESTOS DE ACA ABAJO, NO TIENEN RELEVANCIA PERO DEBEN LLAMARSE ↓
  @override
  void onInsertComplete(message) {}

  @override
  void onInsertError() {}
  @override
  void onDeleteComplete(message) {}
  @override
  void onDeleteError() {}
  @override
  void onLoadComplete( data) {}
  @override
  void onLoadError() {}
  @override
  void oninicioComplete( data) {}
  @override
  void oninicioError() {}
}
