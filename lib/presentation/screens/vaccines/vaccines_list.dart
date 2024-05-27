import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/widgets/vaccines/vaccines_insert.dart';
import 'package:app_tesis/presentation/widgets/vaccines/vaccines_presenter.dart';
import 'package:app_tesis/presentation/widgets/vaccines/vaccines_update.dart';

class ListVaccines extends StatefulWidget {
  const ListVaccines({super.key});

  @override
  State<ListVaccines> createState() => _ListVaccinesState();
}

class _ListVaccinesState extends State<ListVaccines>
    implements VaccinesViewContract {
  final userRol = RolID.id;
  String? campaingId = CampaingId.id;
  String? pigsId = PigsGlobalKey.id;
  List<dynamic> _data = [];
  bool _isLoading = true;
  bool _hasData = true;
  late VaccinesPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = VaccinesPresenter(this);
    _presenter.listVaccines(campaingId!, pigsId!);
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
                "REGISTRO DE CONTROL DE VACUNAS",
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
                _presenter.listVaccines(campaingId!, pigsId!);
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
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
                              itemCount: _data.length,
                              itemBuilder: (context, index) {
                                final data = _data[index];
                                final estado = data["est_control"].toString() ==
                                        '1'
                                    ? "Pendiente"
                                    : (data["est_control"].toString() == '2'
                                        ? "Completa"
                                        : (data["est_control"].toString() == '3'
                                            ? "Sin Realizar"
                                            : "Otros"));
                                DateTime fechaModificacion =
                                    DateTime.parse(data["fechMod_control"]);
                                DateTime fechaActual = DateTime.now();
                                Duration diferencia =
                                    fechaActual.difference(fechaModificacion);
                                int diasTranscurridos = diferencia.inDays;
                                return CardRows(
                                    title1: 'Código',
                                    subtitle1:
                                        '${data["codigo"] ?? "Sin Código"}',
                                    title2: 'Peso Registrado',
                                    subtitle2:
                                        '${data["peso_res"].toString()} Kg.',
                                    title3: 'Nombre de Vacuna',
                                    subtitle3: '${data["n_vacunas"] ?? "00"} ',
                                    title4: 'Fecha',
                                    subtitle4: fecha('${data["fecha_vacuna"]}'),
                                    title5: 'Estado',
                                    text5: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: data["est_control"].toString() ==
                                              '1'
                                          ? Colors.orange
                                          : (data["est_control"].toString() ==
                                                  '2'
                                              ? Colors.green.shade400
                                              : (data["est_control"]
                                                          .toString() ==
                                                      '3'
                                                  ? Colors.red.shade200
                                                  : Colors.black)),
                                    ),
                                    subtitle5: estado,
                                    id: data["id_control"].toString(),
                                    onDelete: (id) {
                                      if (permission?.canDelete ?? false) {
                                        _presenter.deleteVaccines(id);
                                      } else {
                                        AlertMessages.alertInfo(context,
                                            Messages().messagePermission);
                                      }
                                    },
                                    onEdit: () {
                                      if (permission?.canEdit ?? false) {
                                        if (diasTranscurridos <= 5) {
                                          // Menos de 5 días desde la última modificación, permite la actualización
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateVacciness(
                                                          id:
                                                              data["id_control"]
                                                                  .toString(),
                                                          nVacines:
                                                              data["n_vacunas"],
                                                          fechaVaccines: data[
                                                              "fecha_vacuna"])));
                                        } else {
                                          // Más de 5 días desde la última modificación, muestra un mensaje
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor:
                                                  Colors.blue.shade400,
                                              content: Text(
                                                  'Han pasado más de $diasTranscurridos  días desde la última modificación y no se puede actualizar.'),
                                              duration: Duration(seconds: 5),
                                            ),
                                          );
                                        }
                                      } else {
                                        AlertMessages.alertInfo(context,
                                            Messages().messagePermission);
                                      }
                                    });
                              },
                            )
                          : Center(
                              child: Text(
                                Messages().messageListNot,
                                style: const TextStyle(color: Colors.red),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateVaccines()));
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
  void onLoadListComplete(List<dynamic> data) {
    if (mounted) {
      setState(() {
        _data = data;
        _isLoading = false;
        _hasData = data.isNotEmpty;
      });
    }
  }

  @override
  void onLoadListError() {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasData = false;
      });
      AlertMessages.alertInfo(context, Messages().messageCargaError);
    }
  }

  @override
  void onUpdateComplete(message) {}
  @override
  void onUpdateError() {}
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
  void onInsertComplete(message) {}
  @override
  void onInsertError() {}
}
