import 'package:app_tesis/constants/colors.dart';
import 'package:app_tesis/constants/pigs_key_selection.dart';
import 'package:flutter/material.dart';

class BuildCard extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;
  final int index;
  final IconData leading;

  const BuildCard({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
    required this.index,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 105,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, // Ancho igual al ancho del dispositivo
                  height: 90,
                  decoration: BoxDecoration(
                    color: cardColors[index % cardColors.length],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(162, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          leading,
                          color: MisColores.black,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          text1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MisColores.blanco,
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: const EdgeInsets.only(
                          bottom: 10), // Ajuste del margen inferior
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(162, 0, 0, 0),
                          ),
                        ],
                      ),
                      width: 110,
                      height: 80,
                      child: Center(
                        child: Text(
                          text2,
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum ActionType {
  Navigate, 
  ShowDialog, 
  noAction
}

class CardText extends StatelessWidget {
  final String text1;
  final String text2;
  final ActionType actionType;
  final dynamic actionTarget;
  final int index;
  final IconData leading;
  final String? pigId; // Parámetro opcional para PigsGlobalKey.id
  final String? id; // Nuevo parámetro opcional para un id adicional

  const CardText({
    Key? key,
    required this.text1,
    required this.text2,
    required this.actionType,
    required this.actionTarget,
    required this.index,
    required this.leading,
    this.pigId, // Parámetro opcional para PigsGlobalKey.id
    this.id, // Nuevo parámetro opcional para un id adicional
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Condicionar el comportamiento según el tipo de acción
          if (actionType == ActionType.Navigate) {
            // Si se navega a otra vista, asigna PigsGlobalKey.id si está disponible
            if (pigId != null) {
              PigsGlobalKey.id = pigId!;
            }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => actionTarget));
          } else if (actionType == ActionType.ShowDialog) {
            actionTarget();
          } else if (actionType == ActionType.noAction) {
            
          }
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    leading,
                    size: 24,
                    color: Colors.blue, // Color de icono ajustable
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        text2,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey, // Color de texto ajustable
                        ),
                      ),
                    ],
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
