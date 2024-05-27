import 'package:app_tesis/presentation/routes/routess.dart';

class FoodsScreen extends StatefulWidget {
  const FoodsScreen({super.key});

  @override
  State<FoodsScreen> createState() => _FoodsScreenState();
}

class _FoodsScreenState extends State<FoodsScreen>
    with SingleTickerProviderStateMixin
    implements FoodsViewContract {
  late AnimationController _animationController;
  bool _isOpened = false;
  String? campaingID = CampaingId.id;
  List< dynamic> _data = [];
  bool _isLoading = true;
  bool _hasData = true;
  late FoodsPresenter _presenter;
  final userRol = RolID.id;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _presenter = FoodsPresenter(this);
    _presenter.loadFoods(CampaingId.id!);
    _presenter.loadFoods(CampaingId.id!);
  }

  @override
  Widget build(BuildContext context) {
    final permissions = userRoles[userRol];
    return Scaffold(
        backgroundColor: MisColores.blanco,
        appBar: AppBar(
          backgroundColor: MisColores.blanco,
        ),
        body: Column(
          children: [
            SizeBoxWidget.sizedBox('LISTA DE ALIMENTOS'),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _presenter.loadFoods(campaingID!);
                },
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25)),
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
                                  return CardRows(
                                      onEdit: () {
                                        if (permissions?.canEdit ?? false) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateFoods(
                                                          nombre: _data[index][
                                                              'nombre'].toString(),
                                                          cant: _data[index][
                                                              'cant'].toString(),
                                                          proveedor:
                                                              _data[index][
                                                                  'proveedor'].toString(),
                                                          precio:
                                                              _data[
                                                                      index]
                                                                  ['precio'].toString(),
                                                          porcentaje: _data[
                                                                  index]
                                                              ['porc_proteina'].toString(),
                                                          id: _data[index]
                                                              ['id'].toString())));
                                        } else {
                                          AlertMessages.alertInfo(
                                              context, Messages().messagePermission);
                                        }
                                      },
                                      onDelete: (id) {
                                        if (permissions?.canDelete ?? false) {
                                          AlertMessages.showConfirmation(
                                              context,
                                              'ELIMINAR REGISTRO',
                                              'Desea eliminar este registro?',
                                              () async {
                                            _presenter.delete(id);
                                          });
                                        } else {
                                          AlertMessages.alertInfo(
                                              context, Messages().messagePermission);
                                        }
                                      },
                                      title1: 'Nombre',
                                      subtitle1: '${data["nombre"] ?? 'No registrado'} ',
                                      title2: 'Cantidad',
                                      subtitle2: '${data["cant"] ?? '0.00'} Kg',
                                      title3: 'Proveedor',
                                      subtitle3: '${data["proveedor"]?? 'Sin proveedor'} Kg',
                                      title4: 'Precio Total',
                                      subtitle4:  'S/. ${data["total"] ?? '0.00'}',
                                      title5: 'Porc. U / Porc. T',
                                      subtitle5:
                                          '${data["porc_proteina"] ?? '0.00'} % / ${data["porc_total"]??  '0.00'}%',
                                      id: data["id"].toString());
                                },
                              )
                            :  Center(
                                child: Text(
                                  Messages().messageListNot,
                                  style: const TextStyle(color: Colors.redAccent),
                                ),
                              )),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionBubble(
          items: <Bubble>[
            Bubble(
              icon: Icons.create,
              iconColor: MisColores.blanco,
              title: 'Crear Nuevo Alimento',
              titleStyle: TextStyle(fontSize: 14, color: MisColores.blanco),
              bubbleColor: MisColores.primary,
              onPress: () {
                if (permissions?.canInsert ?? false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateFoods()));
                } else {
                  AlertMessages.alertInfo(context, Messages().messagePermission);
                }
              },
            ),
            Bubble(
              icon: Icons.create,
              iconColor: MisColores.blanco,
              title: 'Crear Receta',
              titleStyle: TextStyle(fontSize: 14, color: MisColores.blanco),
              bubbleColor: MisColores.primary,
              onPress: () {
                if (permissions?.canInsert ?? false) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RecetsInsert()));
                }
              },
            ),
          ],
          onPress: () {
            setState(() {
              _isOpened = !_isOpened;
            });
            if (_isOpened) {
              _animationController.forward();
            } else {
              _animationController.reverse();
            }
          },
          animation: _animationController,
          animatedIconData: AnimatedIcons.menu_close,
          iconColor: MisColores.blanco,
          backGroundColor: Colors.green,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndFloat);
  }

  @override
  void onFoodsDeleteComplete(message) {
    if (message == 'success') {
    AlertMessages.alertSuccess(context, Messages().messageDeleteSucces);
    _presenter.loadFoods(campaingID!);
    }
  }

  @override
  void onFoodsDeleteError() {
    AlertMessages.alertErrors(context,Messages().messageDeleteError);
  }

@override
void onLoadFoodsComplete(List data) {
  if (mounted) {
    setState(() {
      _data = data;
      _isLoading = false;
      _hasData = data.isNotEmpty;
    });
  }
}

  @override
  void onLoadFoodsError() {
    setState(() {
      _isLoading = false;
      _hasData = false;
    });
    AlertMessages.alertInfo(context, Messages().messageCargaError);
  }

  @override
  void onFoodsInsertComplete(message) {}

  @override
  void onFoodsInsertError() {}

  @override
  void onFoodsUpdateComplete(message) {}

  @override
  void onFoodsUpdateError() {}
}
