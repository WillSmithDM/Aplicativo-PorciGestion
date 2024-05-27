import 'package:app_tesis/data/Receta/recetas_data.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class RecetasList extends StatefulWidget {
  const RecetasList({super.key});

  @override
  State<RecetasList> createState() => _RecetasListState();
}

class _RecetasListState extends State<RecetasList> {
  final String idPig = PigsGlobalKey.id!;
  final String idCamp = CampaingId.id!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MisColores.blanco,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RecetsInsert()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
            SizeBoxWidget.sizedBox('LISTA DE RECETAS'),
          Expanded(
            
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: MisColores.fondo,
              ),
              child: FutureBuilder<List<dynamic>>(
                future: RecetRepositoryImpl().getReceta(idCamp, idPig),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        Messages().messageListNot,
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  } else {
                    List<dynamic> alimentosList = snapshot.data!;
                    Map<String, List<Map<dynamic, dynamic>>> groupedRecipes = {};
                    Map<String, double> totalCantidadPorReceta = {};
                    Map<String, double> porcentajeProteinaTotal = {};
            
                    for (var alimento in alimentosList) {
                      String id = alimento['id'].toString();
                      if (!groupedRecipes.containsKey(id)) {
                        groupedRecipes[id] = [alimento];
                        totalCantidadPorReceta[id] =
                            double.parse(alimento['cant_aliment'].toString());
                        porcentajeProteinaTotal[id] =
                            double.parse(alimento['porc_protetotal'].toString());
                      } else {
                        groupedRecipes[id]!.add(alimento);
                        totalCantidadPorReceta[id] =
                            (totalCantidadPorReceta[id] ?? 0) +
                                double.parse(alimento['cant_aliment'].toString());
                      }
                    }
            
                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      children: buildRecipeList(groupedRecipes,
                          totalCantidadPorReceta, porcentajeProteinaTotal),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildRecipeList(
      Map<String, List<Map<dynamic, dynamic>>> groupedRecipes,
      Map<String, double> totalCantidadPorReceta,
      Map<String, double> porcentajeProteinaTotal) {
    List<Widget> recipeWidgets = [];

    groupedRecipes.forEach((id, recipeList) {
      List<Widget> recipeItems = recipeList.map((recipe) {
        return Row(
          children: [
            Expanded(
              child: Text(recipe['nombre']),
            ),
            Expanded(
              child: Text('${recipe['cant_aliment']} g.'),
            ),
            Expanded(
              child: Text('${recipe['porc_prot']}'),
            )
          ],
        );
      }).toList();

      recipeWidgets.add(
        Card(
          margin: EdgeInsets.only(bottom: 16),
          color: Colors.grey.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Alimentos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Cantidad',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Porcentaje de Proteína',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'Delete',
                          child: Text('Eliminar'),
                        ),
                      ],
                      onSelected: (value) async {
                        if (value == 'Delete') {
                          String deleted =
                              await RecetRepositoryImpl().deleteRecet(id);
                          if (deleted == "success") {
                            AlertMessages.alertSuccess(
                                context, Messages().messageDeleteSucces);
                          } else {
                            AlertMessages.alertErrors(
                                context, Messages().messageDeleteError);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: recipeItems,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '-----------',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '-----',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total de Cantidad',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${totalCantidadPorReceta[id]} G.',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total de Porcentaje de Proteína',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${porcentajeProteinaTotal[id]} %',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });

    return recipeWidgets;
  }
}
