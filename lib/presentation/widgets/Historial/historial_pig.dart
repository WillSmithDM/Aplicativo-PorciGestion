import 'package:app_tesis/data/Historial/historial_data.dart';
import 'package:app_tesis/domain/repositories/historial_repository.dart';
import 'package:app_tesis/domain/models/ModelosPDF/modelpdf_HC.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class HistorialPigClinic extends StatefulWidget {
  const HistorialPigClinic({super.key});

  @override
  State<HistorialPigClinic> createState() => _HistorialPigClinicState();
}

class _HistorialPigClinicState extends State<HistorialPigClinic>
    implements HistorialViewContract {
  String campaingId = CampaingId.id!;
  String pigId = PigsGlobalKey.id!;
  String idUser = UserID.id!;
  final TextEditingController _enfermedadesController = TextEditingController();
  final TextEditingController _observacionesController =
      TextEditingController();
  late HistorialRepository _historialRepository;
  late HistorialPresenter _presenter;
  List _data = [];
  bool _isLoading = true;
  bool _hasData = true;
  @override
  void initState() {
    super.initState();
    _presenter = HistorialPresenter(this);
    _historialRepository = HistorialRepositoryImpl();
    _presenter.listHistorial(campaingId, pigId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.blanco,
      appBar: AppBar(
        backgroundColor: MisColores.blanco,
        actions: [
          IconButton(
              iconSize: 35,
              onPressed: () {
                _showConfirmationDialog(context);
              },
              icon: Icon(Icons.download))
        ],
      ),
      body: Column(
        children: [
          SizeBoxWidget.sizedBox("Fichas Clinicas"),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _presenter.listHistorial(campaingId, pigId);
              },
              child: Container(
                padding: EdgeInsets.only(top: 10),
                decoration: MisDecoraciones.miDecoracion(),
                child: _isLoading
                    ? Center(
                        child: DataCarga.loading(),
                      )
                    : _hasData
                        ? ListView.builder(
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              final data = _data[index];
                              return CardText(
                                id: data["id_historial"].toString(),
                                actionType: ActionType.noAction,
                                text1: data["nombre_historial"],
                                text2: 'Porcino: ${data["codigo"]}',
                                actionTarget: null,
                                index: index,
                                leading: Icons.document_scanner_outlined,
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
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        backgroundColor: MisColores.primary,
        child: const Icon(Icons.add,
            color: MisColores.blanco), // Color del botón flotante
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar descarga"),
          content: const Text("¿Desea descargar el PDF?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                generate();
                Navigator.pop(context);
              },
              child: const Text("Descargar"),
            ),
          ],
        );
      },
    );
  }

  void generate() async {
    final data = await _historialRepository.getHistorialList(campaingId, pigId);
    final dataList = data.cast<Map<dynamic, dynamic>>();
    final response = await generatePdf(dataList, context);
    if (response == true) {
      AlertMessages.alertSuccess(context, 'Descarga Exitosa');
    } else {
      AlertMessages.alertErrors(
          context, 'Error en la Descarga por Datos vacios');
    }
  }

  Future<void> _showFormDialog(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1));
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Datos para la ficha técnica"),
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.8, // Tamaño definido para el contenido
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Ajuste el tamaño principal a min para evitar problemas de desbordamiento
              children: [
                TextField(
                  controller: _enfermedadesController,
                  decoration: const InputDecoration(labelText: 'Enfermedades'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _observacionesController,
                  decoration: const InputDecoration(labelText: 'Observaciones'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                insertHistorial();
              },
              child: const Text("Guardar"),
            ),
          ],
        );
      },
    );
  }

  void insertHistorial() {
    final data = {
      "observaciones": _observacionesController.text,
      "Emferm": _enfermedadesController.text
    };
    _presenter.insertHistorial(campaingId, pigId, idUser, data);
  }

  @override
  void onInsertComplete(message) {
    if (message == "success") {
      AlertMessages.alertSuccess(context, Messages().messageInsertSucces);
      _enfermedadesController.text = '';
      _observacionesController.text = '';
    }
  }

  @override
  void onInsertError() {
    AlertMessages.alertErrors(context, Messages().messageInsertError);
  }

  @override
  void onLoadHistorialComplete(List datah) {
    if (mounted) {
      setState(() {
        _data = datah;
        _isLoading = false;
        _hasData = datah.isNotEmpty;
      });
    }
  }

  @override
  void onLoadHistorialError() {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasData = false;
      });
      AlertMessages.alertinfo(context, Messages().messageCargaError);
    }
  }

  @override
  void onLoadPigComplete(List data) {}
  @override
  void onLoadPigError() {}
  @override
  void onLoadinfoComplete(List data3) {}
  @override
  void onLoadinfoError() {}
}
