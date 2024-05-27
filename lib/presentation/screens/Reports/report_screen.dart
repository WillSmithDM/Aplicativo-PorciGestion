import 'package:app_tesis/data/pigs/pigs_data.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String idCamp = CampaingId.id!;
  String? _selectedPig;
  List< dynamic> _pigsData = [];
  String? _selectedPigid;

  @override
  void initState() {
    super.initState();
    loadPig();
  }

  void loadPig() async {
    try {
      final pigsData = await PigsRepositoryImpl().getPigs(idCamp);
      if (mounted) {
        setState(() {
          _pigsData = pigsData;
        });
      }
    } catch (e) {
      AlertMessages.alertInfo(context, Messages().messageCargaError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MisColores.blanco,
      ),
      body: Column(
        children: [
          SizeBoxWidget.sizedBox("Reportes"),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: MisDecoraciones.miDecoracion(),
              child: GridView.count(
                crossAxisCount: 2, // Dos elementos por fila
                mainAxisSpacing: 10.0, // Espaciado vertical entre elementos
                crossAxisSpacing: 10.0, // Espaciado horizontal entre elementos
                padding: EdgeInsets.all(10.0),
                children: [
                  ReportCard(
                    title: 'Control de Vacunas',
                    onPressed: () {
                      _showDialogButtons(context);
                    },
                  ),
                  ReportCard(
                    title: 'Control de Pesos',
                    onPressed: () {
                      _showDialogButtons(context);
                    },
                  ),
                  ReportCard(
                    title: 'Recetas',
                    onPressed: () {
                      _showDialogButtons(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogButtons(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ReportDialog(
        onGeneralDownloadPressed: () {
          print('Descarga General');
        },
        onSpecificDownloadPressed: () {
          seleccion(context);
        },
      ),
    );
  }

  void seleccion(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Seleccionar Porcino'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField2<String>(
                          dropdownStyleData: DropdownStyleData(maxHeight: 200),
                          isExpanded: true,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          hint: Text(
                            'Eliga un Porcino',
                            style: TextStyle(fontSize: 14),
                          ),
                          items: _pigsData.map((item) {
                            final String pigCode = item['codigo'];
                            return DropdownMenuItem<String>(
                              value: pigCode,
                              child: Text(
                                pigCode,
                                style: TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          value: _selectedPig,
                          onChanged: (value) {
                            _selectedPig = value;
                            _selectedPigid = _pigsData.firstWhere(
                                (element) => element['codigo'] == value)['id'];
                          },
                          onSaved: (value) {
                            _selectedPig = value;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(onPressed: () {}, child: Text('Guardar'))
              ],
            ),
          );
        });
  }
}
