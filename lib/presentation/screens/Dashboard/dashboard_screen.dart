import 'package:app_tesis/constants/reload_data.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class DashboardScreen extends StatefulWidget {
  static String id = "Dashboard_id";
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    implements DashboardViewContract {
  bool _isLoading = true;
  String? campaingId = CampaingId.id;
  List<dynamic> _data = [];
  List<dynamic> _datah = [];
  List<dynamic> _data3 = [];
  final userRol = RolID.id;
  late DataReloader _dataReloader;

  late DashboardPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = DashboardPresenter(this);
    _dataReloader = DataReloader(fetchData);
    _dataReloader.startReloafing();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _dataReloader.stopReloading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.fondo50,
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator(), // Muestra un indicador de carga
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: 120,
                      color: MisColores.primary,
                      child: const Center(
                        child: Text(
                          "INICIO",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: MisColores.blanco,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        // Columna 1
                        Expanded(
                          child: _buildLargeCard(
                            'res/pig.png',
                            'Porcinos Registrados',
                            'Total: ${_data.isNotEmpty ? _data[0]["TotalPigs"] : ""}',
                            'Top Peso',
                            '${_data.isNotEmpty ? _data[0]["codPorcino"] : ""} - ${_data.isNotEmpty ? _data[0]["porcinoMax"] : ""} Kg.',
                            context,
                          ),
                        ),
                        SizedBox(width: 20), // Espacio entre columnas
                        // Columna 2
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              for (var item in _data)
                                _buildCard(
                                  'res/historial.png',
                                  'Ctr. de Pesos Realizados',
                                  'Total: ${item["TotalPesos"] ?? "00"}',
                                  context,
                                ),
                              SizedBox(height: 20), // Espacio entre cards
                              for (var item in _data)
                                _buildCard(
                                  'res/vacuna.png',
                                  'Vacunas Realizadas',
                                  'Total: ${item["TotalVacunas"] ?? "00"}',
                                  context,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "ULTIMOS ALIMENTOS",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _datah.length,
                      itemBuilder: (context, index) {
                        if (index == _datah.length - 1) {
                          return _buildCircularCard(context);
                        } else {
                          return _buildHorizontalCard(
                              '${_data.isNotEmpty ? _datah[index]["nombre"] : ""}',
                              'Cant. Actual: ${_data.isNotEmpty ? _datah[index]["cant"] ?? "0.00" : ""}Kg.',
                              '${_data.isNotEmpty ? _datah[index]["porc_proteina"] ?? "0.00" : ""}',
                              ' % de Proteina');
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "Vacunas Pendientes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _data3.length,
                      itemBuilder: (context, index) {
                        return _buildConfirmationCard(
                            context,
                            _data3[index]["n_vacunas"],
                            'Porcino : ${_data3[index]["codigo"]}',
                            index);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildLargeCard(
    String iconPath,
    String title,
    String subtitle,
    String title2,
    String subtitle2,
    BuildContext context,
  ) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
        color: MisColores.blanco,
        elevation: 5,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // Contenedor para el icono
                  alignment: Alignment.center,
                  child: Image.asset(
                    iconPath,
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MisColores.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 12, color: MisColores.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    title2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: MisColores.primary),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    subtitle2,
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 10, color: MisColores.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
      String iconPath, String title, String subtitle, BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width / 2.5,
      child: Card(
        color: MisColores.blanco,
        elevation: 5,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MisColores.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    subtitle,
                    style:
                        const TextStyle(fontSize: 12, color: MisColores.black),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 40,
                height: 40,
                child: Image.asset(
                  iconPath,
                  width: 40,
                  height: 40,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCard(
      String title, String body, String finalText, String subttitle3) {
    return SizedBox(
      width: 150,
      child: Card(
        elevation: 5,
        color: MisColores.blanco,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black38, width: 0.1),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                  50)), // Ajusta el radio de las esquinas según sea necesario
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: MisColores.primary),
              ),
              const SizedBox(height: 5),
              Text(
                body,
                style: const TextStyle(color: MisColores.primary, fontSize: 14),
              ),
              const SizedBox(height: 15),
              Row(
                // Utilizamos un Row para alinear los textos horizontalmente
                children: [
                  Expanded(
                    child: Text(
                      finalText,
                      style: const TextStyle(
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    subttitle3,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCircularCard(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Card(
        elevation: 5,
        shape: const CircleBorder(),
        child: IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            if (viewPermissions[userRol]?['Alimentos'] ?? false) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FoodsScreen()),
              );
            } else {
              AlertMessages.alertInfo(context, Messages().messagePermission);
            }
          },
        ),
      ),
    );
  }

  Widget _buildConfirmationCard(
      BuildContext context, String text1, String text2, int index) {
    return Card(
      color: MisColores.primary,
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: ListTile(
        title: Text(
          text1,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: MisColores.blanco),
        ),
        subtitle: Text(
          text2,
          style: const TextStyle(color: MisColores.blanco),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.check_circle_outline,
            color: MisColores.blanco,
          ),
          onPressed: () {
            final permissions = userRoles[userRol];
            if (permissions?.canUpdateVaccines ?? false) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirmar Vacuna Realizada'),
                    content: const Text(
                        '¿Está seguro de que desea confirmar que la vacuna ha sido realizada?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          updateVacc(_data3[index]);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Aceptar'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancelar'),
                      ),
                    ],
                  );
                },
              );
            } else {
              AlertMessages.alertInfo(context, Messages().messagePermission);
            }
          },
        ),
      ),
    );
  }

  void updateVacc(data) {
    _presenter.updatePendi(data["id_camp"].toString(),
        data["porcino_id"].toString(), data["id"].toString());
    _presenter.vaccinesPend(campaingId!);
  }

  @override
  void onLoadParte1Complete(List<dynamic> data) {
    if (mounted) {
      setState(() {
        _data = data;
      });
      _setLoading(false);
    }
  }

  @override
  void onLoadParte1Error() {
    AlertMessages.alertErrors(context, Messages().messageCargaError);
  }

  @override
  void onLoadParte2Complete(List<dynamic> datah) {
    if (mounted) {
      setState(() {
        _datah = datah;
      });
      _setLoading(
          false); // Establece isLoading en false una vez que se cargan los datos
    }
  }

  @override
  void onLoadParte2Error() {
    AlertMessages.alertErrors(context, Messages().messageCargaError);
  }

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  @override
  void onLoadParte3Complete(List<dynamic> data3) {
    if (mounted) {
      setState(() {
        _data3 = data3;
      });
      _setLoading(false);
    }
  }

  @override
  void onLoadParte3Error() {
    AlertMessages.alertErrors(context, Messages().messageCargaError);
  }

  @override
  void onUpdateVacComplete() {
    AlertMessages.alertSuccess(context, Messages().messageUpdateSucces);
    _presenter.vaccinesPend(campaingId!);
  }

  @override
  void onUpdateVacError() {
    AlertMessages.alertErrors(context, Messages().messageUpdateError);
  }

  void fetchData() {
    _presenter.cantDashboard(campaingId!);
    _presenter.horizontalDash(campaingId!);
    _presenter.vaccinesPend(campaingId!);
  }
}
