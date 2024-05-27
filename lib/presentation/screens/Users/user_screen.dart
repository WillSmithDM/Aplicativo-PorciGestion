import 'package:app_tesis/presentation/routes/routess.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> implements UserViewContract {
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;
  bool _hasData = true;
  late UserPresenter _presenter;
  final userRol = RolID.id;
  @override
  void initState() {
    super.initState();
    _presenter = UserPresenter(this);
    _presenter.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final permission = userRoles[userRol];
    return Scaffold(
      backgroundColor: MisColores.blanco,
      appBar: AppBar(
        backgroundColor: MisColores.blanco,
      ),
      body: Column(
        children: [
          SizeBoxWidget.sizedBox('Lista de Usuarios'),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _presenter.loadUser();
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25)),
                    color: MisColores.blanco,
                  ),
                  child: _isLoading
                      ? Center(
                          child: DataCarga.loading(),
                        )
                      : _hasData
                          ? ListView.builder(
                              itemCount: _data.length,
                              itemBuilder: (context, index) {
                                final data = _data[index];
                                return CardRows(
                                  title1: 'DNI',
                                  subtitle1: data["dni"],
                                  title2: 'Nombres',
                                  subtitle2: data["name"],
                                  title3: 'Apellidos',
                                  subtitle3: data["firstname"],
                                  title4: 'Telefono',
                                  subtitle4: data["phone"],
                                  title5: 'Usuario',
                                  subtitle5: data["usuario"],
                                  id: data["id"].toString(),
                                  onDelete: (id) {
                                    if (permission?.canDelete ?? false) {
                                      AlertMessages.showConfirmation(
                                          context,
                                          'Eliminar Registro',
                                          'Desea eliminar este registro?',
                                          () async {
                                        _presenter.deleteUser(id);
                                      });
                                    } else {
                                      AlertMessages.alertInfo(context,
                                          Messages().messagePermission);
                                    }
                                  },
                                  onEdit: () {
                                    if (permission?.canEdit ?? false) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UpdateUser(
                                            dni: data["dni"],
                                            id: data["id"].toString(),
                                            email: data["email"],
                                            firstname: data["firstname"],
                                            name: data["name"],
                                            password: data["password"],
                                            phone: data["phone"],
                                            username: data["usuario"],
                                            rol: data['rol_id'].toString(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      AlertMessages.alertInfo(context,
                                          Messages().messagePermission);
                                    }
                                  },
                                );
                              },
                            )
                          : const Center(
                              child: Text(
                                "NO HAY DATOS REGISTRADOS",
                                style: TextStyle(color: Colors.redAccent),
                              ),
                            )),
            ),
          )
        ],
      ),
      floatingActionButton: Container(
        height: 55.0,
        width: 55.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              if (permission?.canInsert ?? false) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateUser(),
                  ),
                );
              } else {
                AlertMessages.alertInfo(context, Messages().messagePermission);
              }
            },
            backgroundColor: MisColores.primary,
            child: const Icon(
              Icons.add,
              color: MisColores.blanco,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


  @override
  void onDeleteComplete(message) {
    if (message == "success") {
    AlertMessages.alertSuccess(context, Messages().messageDeleteSucces);
      
    }
  }

  @override
  void onDeleteError() {
    AlertMessages.alertErrors(context, Messages().messageDeleteError);
  }

  @override
  void onLoadComplete(List<dynamic> data) {
    
  }
  @override
  void onLoadError() {
    
  }



  @override
  void onUpdateComplete(message) {}
  @override
  void onUpdateError() {}
  @override
  void oninicioComplete(List<dynamic> data) {

    if (mounted) {
      setState(() {
        _data = data.cast<Map<String, dynamic>>();

        _isLoading = false;
        _hasData = data.isNotEmpty;
      });
    }
  }
  @override
  void oninicioError() {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasData = false;
      });
    }
    AlertMessages.alertInfo(context, Messages().messageCargaError);
  }
  @override
  void onInsertComplete(message) {}
  @override
  void onInsertError() {}
}
