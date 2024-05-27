import 'package:app_tesis/data/Alimentos/alimentos_data.dart';
import 'package:app_tesis/data/Receta/recetas_data.dart';
import 'package:app_tesis/data/pigs/pigs_data.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class RecetsInsert extends StatefulWidget {
  const RecetsInsert({super.key});

  @override
  State<RecetsInsert> createState() => _RecetsInsertState();
}

class _RecetsInsertState extends State<RecetsInsert> {
  String? idCamp = CampaingId.id;
  String? _selectedPigCode;
  String? _selectedFoodName;
  double? _selectedFoodProteins;
  List<dynamic> _pigsData = [];
  List<dynamic> _foodsData = [];
  List<String> savedItems = [];
  String? _idReceta;
  String? _selectedPigId;

  TextEditingController _cantController = TextEditingController();

  final RecetRepositoryImpl _repository = RecetRepositoryImpl();
  @override
  void initState() {
    super.initState();
    loadPigs();
    loadFoods();
    insertReceta();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.blanco,
      appBar: AppBarWidget.appBar('Crear Receta'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(22),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField2(
                      dropdownStyleData: DropdownStyleData(maxHeight: 200),
                      isExpanded: true,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      hint: Text(
                        'Seleccionar Porcino',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: _pigsData.map((item) {
                        final String pigCode = item['codigo'];
                        return DropdownMenuItem<String>(
                          value: pigCode,
                          child: Text(
                            pigCode,
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      value: _selectedPigCode,
                      onChanged: (value) {
                        setState(() {
                          _selectedPigCode = value;
                          _selectedPigId = _pigsData
                              .firstWhere(
                                  (element) => element['codigo'] == value)['id']
                              .toString();
                        });
                      },
                      onSaved: (value) {
                        _selectedPigCode = value;
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detalles',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Agregar Elemento'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DropdownButtonFormField2<String>(
                                        dropdownStyleData:
                                            DropdownStyleData(maxHeight: 200),
                                        isExpanded: true,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 16),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        hint: Text(
                                          'Seleccionar Alimento',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        items: _foodsData.map((item) {
                                          final String food = item['nombre'];
                                          return DropdownMenuItem<String>(
                                            value: food,
                                            child: Text(
                                              food,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          );
                                        }).toList(),
                                        value: _selectedFoodName,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedFoodName = value;
                                            // Obtener el porcentaje de proteína como un double
                                            _selectedFoodProteins =
                                                double.parse(_foodsData
                                                        .firstWhere((element) =>
                                                            element['nombre'] ==
                                                            value)[
                                                    'porc_proteina']);
                                          });
                                        },
                                        onSaved: (value) {
                                          _selectedFoodName = value;
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      TextFormField(
                                        controller: _cantController,
                                        decoration: InputDecoration(
                                            labelText:
                                                'Ingrese cantidad en gramos'),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      String selectedItem =
                                          _selectedFoodName ?? '';
                                      String enteredText = _cantController.text;

                                      // Validar que se haya seleccionado un alimento
                                      if (selectedItem.isNotEmpty) {
                                        // Obtener el porcentaje de proteína del alimento seleccionado
                                        double? proteinAmount =
                                            _selectedFoodProteins;

                                        // Verificar si la cantidad ingresada es válida
                                        if (enteredText.isNotEmpty) {
                                          // Realizar la operación
                                          double? quantity =
                                              double.tryParse(enteredText);
                                          if (quantity != null &&
                                              proteinAmount != null) {
                                            proteinAmount = (quantity / 1000) *
                                                proteinAmount;
                                            savedItems.add(
                                              '$selectedItem    $enteredText g.    ${proteinAmount.toStringAsFixed(3)} %',
                                            );
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          } else {
                                            AlertMessages.alertInfo(context, 'Por favor ingrese una cantidad correcta');
                                          }
                                        } else {
                                          AlertMessages.alertInfo(context, 'Por favor ingrese la cantidad');
                                        }
                                      } else {
                                       AlertMessages.alertInfo(context, 'Seleccione un Alimento');
                                      }
                                    },
                                    child: Text('Guardar'),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('ALIMENTO', style: TextStyle(fontWeight: FontWeight.bold),)),
                        DataColumn(label: Text('CANTIDAD', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('%PROTEINA', style: TextStyle(fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Ξ', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
                      ],
                      rows: savedItems.map((item) {
                        List<String> rowValues = item.split(' ');
                        return DataRow(cells: [
                          DataCell(Text(rowValues[0])), // ALIMENTO
                          DataCell(Text('${rowValues[4]} g.')), // CANTIDAD
                          DataCell(Text('${rowValues[9]}%')), // %PROTEINA
                          DataCell(IconButton(
                            icon: const  Icon(Icons.delete_outline,color: Colors.red,),
                            onPressed: () {
                              setState(() {
                                savedItems.remove(item);
                              });
                            },
                          )), // ACCIONES
                        ]);
                      }).toList(),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ), // Ajusta el espacio entre la lista y el botón
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedPigCode != null &&
                            _selectedPigId != null) {
                          insertRecetaDetails();
                        } else {
                          AlertMessages.alertInfo(
                              context, 'Por favor, seleccione un porcino');
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void loadPigs() async {
    try {
      final pigsData = await PigsRepositoryImpl().getPigs(idCamp!);
      setState(() {
        _pigsData = pigsData;
      });
    } catch (e) {
      AlertMessages.alertInfo(context, 'Datos no Obtenidos: $e');
    }
  }

  void loadFoods() async {
    try {
      final foodsData = await AlimentosRepositoryImpl().getAlimentos(idCamp!);
      setState(() {
        _foodsData = foodsData;
      });
    } catch (e) {
      AlertMessages.alertInfo(context, 'Datos no Obtenidos : $e');
    }
  }

  void insertReceta() async {
    try {
      final response = await _repository.insertRecet(idCamp!);
      setState(() {
        _idReceta = response[0]['id'].toString();
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      AlertMessages.alertInfo(context, 'Error: $e');
    }
  }

void insertRecetaDetails() async {
    if (_idReceta != null) {
      for (final item in savedItems) {
        final foodName = item.split(' ')[0].trim();
        final foodData = _foodsData.firstWhere(
            (element) => element['nombre'] == foodName,
            orElse: () => null); // Manejar caso en que no se encuentre el alimento
        if (foodData != null) {
          final idAlimento = foodData['id'].toString();
          final cantidad = item.split(' ')[4];
          final porcentaje = item.split(' ')[9];
          String response = await _repository.insertRecetDetails(
              _idReceta!, idAlimento, _selectedPigId!, idCamp!, {
            "cantidad": cantidad,
            "porcentaje": porcentaje,
          });
          if (response == "success") {
            // Eliminar los items guardados
            setState(() {
              savedItems.clear();
            });
            // Limpiar el controlador de texto
            _cantController.clear();
            // Mostrar mensaje de éxito
            AlertMessages.alertSuccess(context, 'Registro Exitoso');
          } else {
            // Mostrar mensaje de error
            AlertMessages.alertErrors(
                context, 'Error al realizar este registro');
          }
        } else {
          // Manejar caso en que no se encuentre el alimento
          AlertMessages.alertErrors(context, 'Alimento no encontrado');
        }
      }
    } else {
      // Manejar caso en que _idReceta sea nulo
      AlertMessages.alertErrors(context, 'ID de receta nulo');
    }
}


  
  
}
