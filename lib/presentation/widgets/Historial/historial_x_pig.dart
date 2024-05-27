// import 'package:app_tesis/presentation/routes/routess.dart';
// import 'package:app_tesis/presentation/widgets/Historial/historial_x_pig.dart';


// class HistorialPigClinic extends StatefulWidget {
//   const HistorialPigClinic({super.key});

//   @override
//   State<HistorialPigClinic> createState() => _HistorialPigClinicState();
// }

// class _HistorialPigClinicState extends State<HistorialPigClinic>
//     implements HistorialViewContract {
//   String campaingId = CampaingId.id!;
//   String pigId = PigsGlobalKey.id!;
//   List<Map<dynamic, dynamic>> _data = [];
//   bool _isLoading = true;
//   bool _hasData = true;
//   late HistorialPresenter _presenter;

//   @override
//   void initState() {
//     super.initState();
//     _presenter = HistorialPresenter(this);
//     _presenter.listHistorial(campaingId, pigId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MisColores.blanco,
//       appBar: AppBar(
//         backgroundColor: MisColores.blanco,
//       ),
//       body: Column(
//         children: [
//           SizeBoxWidget.sizedBox("Fichas Clinicas"),
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 _presenter.listHistorial(campaingId, pigId);
//               },
//               child: Container(
//                 padding: EdgeInsets.only(top: 10),
//                 decoration: MisDecoraciones.miDecoracion(),
//                 child: _isLoading
//                     ? Center(
//                         child: DataCarga.loading(),
//                       )
//                     : _hasData
//                         ? ListView.builder(
//                             itemCount: _data.length,
//                             itemBuilder: (context, index) {
//                               final data = _data[index];
//                               return CardText(
//                                 id: data["id_historial"],
//                                 actionType: ActionType.Navigate,
//                                 text1: data["nombre_historial"],
//                                 text2: 'Porcino: ${data["codigo"]}',
//                                 actionTarget:HistorialxPig(id: data["id_historial"]),
//                                 index: index,
//                                 leading: Icons.document_scanner_outlined,
//                               );
//                             },
//                           )
//                         :  Center(
//                             child: Text(
//                               Messages().messageListNot,
//                               style: const TextStyle(color: Colors.red),
//                             ),
//                           ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   void onLoadHistorialComplete(List<Map> datah) {
//     if (mounted) {
    
//     setState(() {
//       _data = datah;
//       _isLoading = false;
//       _hasData = datah.isNotEmpty;
//     });
//     }
      
//   }

//   @override
//   void onLoadHistorialError() {
//     if (mounted) {
//       setState(() {
//         _isLoading = false;
//         _hasData = false;
//       });
//       AlertMessages.alertinfo(context, Messages().messageCargaError);
//     }
//   }



//   @override
//   void onLoadinfoComplete(List<Map> data3) {}
//   @override
//   void onLoadinfoError() {}
//   @override
//   void onUpdateVacComplete() {}
//   @override
//   void onUpdateVacError() {}
//   @override
//   void onLoadPigComplete(List<Map> data) {}
//   @override
//   void onLoadPigError() {}
// }
