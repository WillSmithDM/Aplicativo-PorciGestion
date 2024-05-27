import 'package:flutter/material.dart';

class CardRows extends StatelessWidget {
  final String title1;
  final String subtitle1;
  final TextStyle? text1;
  final String title2;
  final String subtitle2;
  final TextStyle? text2;
  final String title3;
  final String subtitle3;
  final TextStyle? text3;
  final String title4;
  final String subtitle4;
  final TextStyle? text4;
  final String title5;
  final String subtitle5;
  final TextStyle? text5;
  final void Function()? onEdit;
  final void Function(String)? onDelete;
  final void Function()? onView;
   final String id;

  const CardRows(
      {super.key,
      required this.title1,
      required this.subtitle1,
      this.text1,
      required this.title2,
      required this.subtitle2,
      this.text2,
      required this.title3,
      required this.subtitle3,
      this.text3,
      required this.title4,
      required this.subtitle4,
      this.text4,
      required this.title5,
      required this.subtitle5,
      this.text5,
      this.onEdit,
      this.onDelete,
      this.onView, 
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      padding: const EdgeInsets.all(6),
      constraints:  BoxConstraints(maxHeight: 150),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Columna 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title1,
                        style:  TextStyle(color: Colors.grey, fontSize: 11
                        ),
                      ),
                      SizedBox(height: 3,),
                      Text(
                        subtitle1,
                        style: text1 ??
                             TextStyle(

                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                      ),
                    ],
                  ),
                  // Columna 2
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title2,
                        style:  TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                       SizedBox(height: 3,),
                      Text(
                        subtitle2,
                        style: text2 ??
                             TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                      ),
                    ],
                  ),
                  // Columna 3
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title3,
                        style:  TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                       SizedBox(height: 3,),
                      Text(
                        subtitle3,
                        style: text3 ??
                             TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context)
                    .size
                    .width, // ajusta el ancho del contenedor según sea necesario
                height:
                    1, // ajusta la altura del contenedor según sea necesario
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 7),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Columna 4
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title4,
                        style:  TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        subtitle4,
                        style: text4 ??
                             TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                      ),
                    ],
                  ),
                  // Columna 5
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title5,
                        style:  TextStyle(color: Colors.grey, fontSize: 11),
                      ),
                      Text(
                        subtitle5,
                        style: text5 ??
                             TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                      ),
                    ],
                  ),
                  // Columna 6
                  PopupMenuButton<String>(
                    itemBuilder: (context) => [
                       PopupMenuItem(
                        value: 'Ver',
                        child: Text('Ver más'),
                      ),
                       PopupMenuItem(
                        value: 'Editar',
                        child: Text('Editar'),
                      ),
                       PopupMenuItem(
                        value: 'Eliminar',
                        child: Text('Eliminar'),
                      ),
                    ],
                    onSelected: (String value) {
                      switch (value) {
                        case 'Ver':
                          onView?.call();
                          break;
                        case 'Editar':
                          onEdit?.call();
                          break;
                        case 'Eliminar':
                          onDelete?.call(id);
                          break;
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
