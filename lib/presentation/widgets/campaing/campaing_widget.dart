import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/widgets/campaing/campaing_create.dart';
import 'package:app_tesis/presentation/widgets/campaing/campaing_presenter.dart';
import 'package:app_tesis/presentation/widgets/campaing/camping_update.dart';

class CampaingView extends StatefulWidget {
  const CampaingView({super.key});

  @override
  State<CampaingView> createState() => _CampaingViewState();
}

class _CampaingViewState extends State<CampaingView>
    implements CampaingViewContract {
  final userRol = RolID.id;
  late CampaingPresenter _presenter;
  bool _isLoading = true;
  List<dynamic>   _userdata = [];
  bool _hasData = true;

  @override
  void initState() {
    super.initState();
    _presenter = CampaingPresenter(this);
    _presenter.loadCampaings();
  }

  @override
  void onCampaingCreationComplete(message) {
    if (message == "success") {
      
    AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
    Navigator.pop(context);
    _presenter
        .loadCampaings(); // Recargar las campañas después de crear una nueva
    }
  }

  @override
  void onCampaingCreationError() {
    // Mostrar mensaje de error al usuario
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

  @override
  void onLoadCampaingsComplete(List<dynamic> userdata) {
    if (mounted) {
    setState(() {
      _userdata = userdata;
      _isLoading = false;
      _hasData = userdata.isNotEmpty;
    });
    }
  }

  @override
  void onLoadCampaingsError() {
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
  Widget build(BuildContext context) {
    final permission = userRoles[userRol];
    return Scaffold(
      backgroundColor: MisColores.blanco,
      appBar: AppBar(
        backgroundColor: MisColores.blanco,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 35,
            child: Center(
              child: Text(
                "CAMPAÑAS",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MisColores.primary,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _presenter
                    .loadCampaings(); // Recargar campañas al deslizar hacia abajo
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: MisColores.fondo,
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _hasData
                          ? ListView.builder(
                              itemCount: _userdata.length,
                              itemBuilder: (context, index) {
                                final data = _userdata[index];
                                final estado = data["est"].toString() == '1'
                                    ? "Activo"
                                    : (data["est"].toString() == '0'
                                        ? "Culminada"
                                        : "Otros");
                                return CustomListItem(
                                  leading: const Icon(Icons.timeline),
                                  title: "${data["nombre"]}",
                                  subtitle: estado,
                                  subtitleStyle: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: data["est"].toString() == '1'
                                        ? Colors.green
                                        : (data["est"].toString() == '0'
                                            ? Colors.orange
                                            : Colors.black),
                                  ),
                                  id: data["id"].toString(),
                                  onDelete: (id) {
                                    if (permission?.canDelete ?? false) {
                                      _presenter.deleteCampaing(id);
                                    } else {
                                      AlertMessages.alertInfo(context, Messages().messagePermission);
                                    }
                                  },
                                  onEdit: () {
                                    if (permission?.canEdit ?? false) {
                                      _navigateToEditCampaing(data);
                                    } else {
                                      AlertMessages.alertInfo(context, Messages().messagePermission);
                                    }
                                  },
                                );
                              },
                            )
                          :  Center(
                              child: Text(
                                Messages().messageListNot,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (permission?.canInsert ?? false) {
            _navigateToCreateCampaing();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _navigateToCreateCampaing() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateCampaing()),
    ).then((result) {
      if (result != null && result == true) {
        _presenter.loadCampaings();
      }
    });
  }

  void _navigateToEditCampaing(Map<dynamic, dynamic> data) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditCampaing(
                id: data['id'].toString(),
                nombre: data['nombre'],
                dateInicio: data['inicio'],
                dateFin: data['final'],
                est: data['est'].toString(),
              )),
    );
    if (result != null && result == true) {
      _presenter.loadCampaings();
    }
  }

  @override
  void onCampaingUpdateComplete(message) {
    if (message == "success") {
      
    AlertMessages.alertSuccess(
        context, Messages().messageUpdateSucces);
    Navigator.pop(context);
    }
  }

  @override
  void onCampaingUpdateError() {
    AlertMessages.alertErrors(context,
        Messages().messageUpdateError);
  }
  
  @override
  void onCampaingDeleteComplete(String message) {
    // TODO: implement onCampaingDeleteComplete
  }
  
  @override
  void onCampaingDeleteError() {
    // TODO: implement onCampaingDeleteError
  }
}
