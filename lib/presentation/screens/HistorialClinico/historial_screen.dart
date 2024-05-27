import 'package:app_tesis/presentation/routes/routess.dart';


class HistorialScreen extends StatefulWidget {
  const HistorialScreen({super.key});

  @override
  State<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends State<HistorialScreen>
    implements HistorialViewContract {
  String campaingId = CampaingId.id!;
  List _data = [];
  bool _isLoading = true;
  bool _hasData = true;
  late HistorialPresenter _presenter;
  @override
  void initState() {
    super.initState();
    _presenter = HistorialPresenter(this);
    _presenter.listPig(campaingId);
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
          SizeBoxWidget.sizedBox("Porcinos"),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _presenter.listPig(campaingId);
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
                                    actionType: ActionType.Navigate,
                                    text1: 'Porcino ${data["codigo"]}',
                                    text2: 'Activo',
                                    actionTarget: const HistorialPigClinic(),
                                    pigId: data["id"].toString(),
                                    index: index,
                                    leading: Icons.arrow_forward_ios);
                              },
                            )
                          :  Center(
                              child: Text(
                                Messages().messageListNot,
                                style: const TextStyle(color: Colors.red),
                              ),
                            )),
            ),
          )
        ],
      ),
    );
  }

  @override
  void onLoadPigComplete(List data) {
    if (mounted) {

    setState(() {
      _data = data;
      _isLoading = false;
      _hasData = data.isNotEmpty;
    });
    }
  }

  @override
  void onLoadPigError() {
    if (mounted) {
      setState(() {
        _isLoading = false;
        _hasData = false;
      });
      AlertMessages.alertinfo(context, Messages().messageCargaError);
    }
  }

  @override
  void onLoadHistorialComplete(List datah) {}

  @override
  void onLoadHistorialError() {}

  @override
  void onLoadinfoComplete(List data3) {}

  @override
  void onLoadinfoError() {}

  @override
  void onInsertComplete(message) {}

  @override
  void onInsertError() {}
}
