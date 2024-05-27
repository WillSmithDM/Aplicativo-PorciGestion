import 'package:app_tesis/presentation/routes/routess.dart';

class PigsViews extends StatefulWidget {
  const PigsViews({super.key});

  @override
  State<PigsViews> createState() => _PigsViewsState();
}

class _PigsViewsState extends State<PigsViews> implements PigsViewContract {
  String? campaingId = CampaingId.id;
  final userRol = RolID.id;
  List<dynamic>  _userdata = [];
  bool _isLoading = true;
  bool _hasData = true;
  late PigsPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = PigsPresenter(this);
    _presenter.loadPigs(CampaingId.id!);
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
                "PORCINOS",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: MisColores.primary),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _presenter.loadPigs(campaingId!);
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
                    ? Center(
                        child: DataCarga.loading(),
                      )
                    : _hasData
                        ? ListView.builder(
                            itemCount: _userdata.length,
                            itemBuilder: (context, index) {
                              final data = _userdata[index];
                              return CustomListItem(
                                id: data["id"].toString(),
                                leading: const Icon(CommunityMaterialIcons.pig),
                                title: 'Código: ${data["codigo"]}',
                                subtitle: 'Peso Actual: ${data["peso_i"]}',
                                subtitleStyle: const TextStyle(
                                  color: MisColores.primary,
                                ),
                                onEdit: () {
                                  if (permission?.canEdit ?? false) {
                                    _updatePigs(data);
                                  } else {
                                    AlertMessages.alertInfo(context, Messages().messagePermission);
                                  }
                                },
                                onDelete: (id) {
                                  if (permission?.canDelete ?? false) {
                                    _presenter.deletePigs(id);
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
                          ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        height: 55.0,
        width: 55.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              if (permission?.canInsert ?? false) {
                _insertPigs();
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
  void onLoadPigsComplete(List<dynamic> userdata) {
    if (mounted) {
    setState(() {
      _userdata = userdata;
      _isLoading = false;
      _hasData = userdata.isNotEmpty;
    });
    }
  }

  @override
  void onLoadPigsError() {
    if (mounted) {
    setState(() {
      _isLoading = false;
      _hasData = false;
    });
    }
    AlertMessages.alertInfo(
      context,
      Messages().messageCargaError,
    );
  }

  void _insertPigs() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePigs()),
    );
    if (result != null && result == true) {
      _presenter.loadPigs(campaingId!);
    }
  }

  void _updatePigs(Map<dynamic, dynamic> data) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePigs(
          id: data["id"].toString(),
          codigo: data["codigo"],
          peso: data["peso_i"].toString(),
          coste: data["coste"].toString(),
        ),
      ),
    );
    if (result != null && result == true) {
      _presenter.loadPigs(CampaingId.id!);
    }
  }

  @override
  void onPigsDeleteComplete(message) {
    if (message == "success") {
    AlertMessages.alertSuccess(context, Messages().messageDeleteSucces);
     _presenter.loadPigs(CampaingId.id!);
    }
  }

  @override
  void onPigsDeleteError() {
    AlertMessages.alertErrors(context, Messages().messageDeleteError);
  }

  //MANTENER VACIOS ESTOS DE ACA ABAJO, NO TIENEN RELEVANCIA PERO DEBEN LLAMARSE ↓
  @override
  void onPigsCreateComplete(message) {}
  @override
  void onPigsCreateError() {}
  @override
  void onPigsUpdateComplete() {}
  @override
  void onPigsUpdateError() {}
}
