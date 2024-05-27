import 'package:app_tesis/data/campaing/campaing_data.dart';
import 'package:app_tesis/domain/repositories/campaing_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';

class CampaingSelection extends StatefulWidget {
  const CampaingSelection({super.key});

  @override
  State<CampaingSelection> createState() => CampaingSelectionState();
}

class CampaingSelectionState extends State<CampaingSelection> {
  List<dynamic> userdata = [];
  bool isLoading = true;
  final CampaingRepository _campaingRepository = CampaingRepositoryImpl();

  @override
  void initState() {
    super.initState();
    listCampaing();
  }

  void listCampaing() async {
    if (mounted) {
      try {
        final campaings = await _campaingRepository.getCampaings();
        if (mounted) {  
        setState(() {
          userdata = campaings;
          isLoading = false;
        });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        AlertMessages.alertErrors(
          context,
          Messages().messageCargaError,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Seleccione una Campaña",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: MisColores.primary),
        ),
      ),
      body: isLoading
          ? Center(
              child: DataCarga
                  .loading()) // Muestra un indicador de carga mientras se obtienen los datos
          : GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: userdata.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    CampaingId.id = userdata[index]["id"].toString();
                    Navigator.pushReplacementNamed(context, "/Home");
                  },
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.campaign),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          userdata[index]['nombre'],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
