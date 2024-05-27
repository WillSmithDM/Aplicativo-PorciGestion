import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/screens/weight_control/control_form.dart';
import 'package:app_tesis/presentation/widgets/weight_control/control_presenter.dart';

class ControlViewPigs extends StatefulWidget {
  const ControlViewPigs({super.key});

  @override
  State<ControlViewPigs> createState() => _ControlViewPigsState();
}

class _ControlViewPigsState extends State<ControlViewPigs>
    implements ControlViewContract {
  String? campaingId = CampaingId.id;
  String? pigsID = PigsGlobalKey.id;
  final userRol = RolID.id;
  late ControlPresenter _presenter;
  List _userdata = [];
  bool _isLoading = true;
  bool _hasData = true;

  @override
  void initState() {
    super.initState();
    _presenter = ControlPresenter(this);
    _presenter.loadControlP(campaingId!, pigsID!);
  }

  @override
  Widget build(BuildContext context) {
    final permission = userRoles[userRol];
    return Scaffold(
      backgroundColor: MisColores.blanco,
      appBar: AppBar(
        backgroundColor: MisColores.blanco,
        actions: [
           if (permission?.canInsert ?? false)
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogForm(
                      isEditing: false,
                      onSubmit: (data, isEditing) async {
                        if (!isEditing) {
                          if (mounted) {
                            _presenter.insertControl(
                              data,
                              campaingId!,
                              pigsID!,
                            );
                          }
                        }
                      },
                    );
                  },
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 35,
            child: Center(
              child: Text(
                "REGISTRO DE CONTROL DE PESO",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MisColores.primary),
              ),
              
            ),
            
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _presenter.loadControlP(campaingId!, pigsID!);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: MisColores.fondo50,
                ),
                child: _isLoading
                    ? Center(
                        child: DataCarga.loading(),
                      )
                    : _hasData
                        ? ListView.builder(
                            itemCount: _userdata.length,
                            itemBuilder: (context, index) {
                              final data = _userdata[index];
                              Color additionalColor = Colors.black;
                              double porcentaje =
                                  double.parse(data["porcentaje"]);
                              if (porcentaje < 0) {
                                additionalColor = Colors.red;
                              } else if (porcentaje > 0) {
                                additionalColor = Colors.green;
                              }
                              return CardRows(
                                title1: 'Nombre',
                                subtitle1:
                                    '${data["nom_control"] ?? 'Sin Registro'}',
                                title2: 'Código',
                                subtitle2: '${data["codigo"]}',
                                title3: 'P. Registrado',
                                subtitle3:
                                    '${data["peso_por"].toString()} kg',
                                title4: 'Porc. Crecimiento',
                                subtitle4:
                                    '${data["porcentaje"].toString()} %',
                                text4: TextStyle(
                                    color: additionalColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                title5: 'Fecha',
                                subtitle5: fecha('${data["fech_mod"]}'),
                                id: data["id"].toString(),
                                onDelete: (id) {
                                  if (permission?.canDelete ?? false) {
                                    _presenter.deleteControl(id);
                                  } else {
                                    AlertMessages.alertInfo(
                                        context, Messages().messagePermission);
                                  }
                                },
                                onEdit: () {
                                  if (permission?.canEdit ?? false) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DialogForm(
                                          isEditing: true,
                                          initialWeight: data["peso_por"],
                                          onSubmit: (data, isEditing) async {
                                            if (isEditing) {
                                              if (mounted) {
                                                _presenter.updateControlPigs(
                                                  campaingId!,
                                                  pigsID!,
                                                  _userdata[index]["id"].toString(),
                                                  data,
                                                );
                                              }
                                            }
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    AlertMessages.alertInfo(
                                        context, Messages().messagePermission);
                                  }
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              Messages().messageListNot,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onControlUpdateSuccess(message) {
    if (message == "success") {
      AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
      _presenter.loadControlP(campaingId!, pigsID!);
    }
  }

  @override
  void onControlUpdateError() {
    AlertMessages.alertErrors(context, Messages().messageUpdateError);
  }

  @override
  void onControlInsertComplete(message) {
    if (message == "success") {
      AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
      _presenter.loadControlP(campaingId!, pigsID!);
    }
  }

  @override
  void onControlInsertError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

  @override
  void onLoadControlComplete(List userdata) {
    if (mounted) {
      setState(() {
        _userdata = userdata;
        _isLoading = false;
        _hasData = userdata.isNotEmpty;
      });
    }
  }

  @override
  void onLoadControlError() {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasData = false;
      });
      AlertMessages.alertInfo(
        context,
        Messages().messageCargaError,
      );
    }
  }

  @override
  void onControlDeleteComplete(message) {}
  @override
  void onControlDeleteError() {}
}
