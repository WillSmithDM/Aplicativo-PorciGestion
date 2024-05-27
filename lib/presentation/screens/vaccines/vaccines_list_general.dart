import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/screens/vaccines/vaccines_list.dart';
import 'package:app_tesis/presentation/widgets/vaccines/vaccines_presenter.dart';


class ListVaccinesGeneral extends StatefulWidget {
  const ListVaccinesGeneral({super.key});

  @override
  State<ListVaccinesGeneral> createState() => _ListVaccinesGeneralState();
}

class _ListVaccinesGeneralState extends State<ListVaccinesGeneral>
    implements VaccinesViewContract {
  String? campaingID = CampaingId.id;
  List<dynamic> _data = [];
  bool _isLoading = true;
  bool _hasData = true;
  late VaccinesPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = VaccinesPresenter(this);
    _presenter.listVaccinesGeneral(campaingID!);
  }

  @override
  Widget build(BuildContext context) {
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
                "Lista General",
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
                _presenter.listVaccinesGeneral(campaingID!);
              },
              child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(25)),
                    color: MisColores.fondo,
                  ),
                  child: _isLoading
                      ? Center(
                          child: DataCarga.loading(),
                        )
                      : _hasData
                          ? Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 20.0,
                                        crossAxisSpacing: 12.0),
                                itemCount: _data.length,
                                itemBuilder: (context, index) {
                                  final data = _data[index];
                                  return BuildCard(
                                    leading: CommunityMaterialIcons.pig,
                                    index: index,
                                    text1: '${data['codigo']}',
                                    text2: 'U. Vacuna: ${data['n_vacunas']}',
                                    onTap: () {
                                      PigsGlobalKey.id = _data[index]['id_porcino'].toString();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ListVaccines()),
                                      );
                                    },
                                  );
                                },
                              ),
                            )
                          :  Center(
                              child: Text(
                                Messages().messageListNot,
                                style:  const TextStyle(color: Colors.red),
                              ),
                            )),
            ),
          )
        ],
      ),
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

  /// SE LLAMAN PERO NO SE USAN ↓
@override
void onDeleteComplete(message) {}
@override
void onDeleteError() {}
@override
void onInsertComplete(message) {}
@override
void onInsertError() {}
@override
void onUpdateComplete(message) {}
@override
void onUpdateError() {}
}
