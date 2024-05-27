import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:app_tesis/presentation/screens/weight_control/control_pigs.dart';
import 'package:app_tesis/presentation/widgets/weight_control/control_presenter.dart';


class ControlViewGeneral extends StatefulWidget {
  const ControlViewGeneral({super.key});

  @override
  State<ControlViewGeneral> createState() => _ControlViewGeneralState();
}

class _ControlViewGeneralState extends State<ControlViewGeneral>
    implements ControlViewContract {
  String? campaingId = CampaingId.id;
  List _userdata = [];
  bool _isLoading = true;
  bool _hasData = true;
  late ControlPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = ControlPresenter(this);
    _presenter.loadControlG(campaingId!);
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
                "CONTROL DE PESO",
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
                _presenter.loadControlG(campaingId!);
              },
              child: Container(
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
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
                                mainAxisSpacing: 30.0,
                                crossAxisSpacing: 12.0,
                              ),
                              itemCount: _userdata.length,
                              itemBuilder: (context, index) {
                                final data = _userdata[index];
                                return BuildCard(
                                  leading: CommunityMaterialIcons.pig,
                                  index: index,
                                  text1: '${data["codigo"]}',
                                  text2:
                                      'Peso Actual: ${data["peso_a"]}   Porcentaje de C. : ${data["porcentaje"].toString()}%',
                                  onTap: () {
                                    PigsGlobalKey.id = _userdata[index]["id_porcino"].toString();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ControlViewPigs()),
                                    );
                                  },
                                );
                              },
                            ),
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
    );
  }

  @override
  void onLoadControlComplete(List userdata) {
    if (mounted) {
    setState(() {
      _userdata = userdata;
      _isLoading = false;
      _hasData = userdata.isNotEmpty;
    });
    }
  }

  @override
  void onLoadControlError() {
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
  void onControlDeleteComplete(message) {}
  @override
  void onControlDeleteError() {}
  @override
  void onControlInsertComplete(message) {}
  @override
  void onControlInsertError() {}
  @override
  void onControlUpdateSuccess(message) {}
  @override
  void onControlUpdateError() {}
}
