import 'package:app_tesis/constants/colors.dart';
import 'package:app_tesis/domain/models/ModelosPDF/model_pdf_clinic.dart';
import 'package:flutter/material.dart';

class InformativeSheet extends StatelessWidget {
  final String title;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;

  const InformativeSheet({
    super.key,
    required this.title,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: MisColores.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: ListTile(
              title: const Text(
                "Fecha de Realización: ",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(text1),
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Expanded(
                flex: 1,
                child: Text(
                  "Porcino:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  text2,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Expanded(
                flex: 1,
                child: Text(
                  "Peso Actual:",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(text3),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            title: const Text(
              "Vacunas Realizadas hoy:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(text4),
          ),
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.only(left: 20),
            title: const Text(
              "Observaciones:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(text5),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Descargar PDF'),
                  content: Text('¿Deseas descargar el PDF?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cerrar el diálogo
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () async {
                        // Generar y descargar el PDF
                        await generarYDescargarPDF(context, title, text1, text2, text3, text4, text5);
                        Navigator.of(context).pop(); // Cerrar el diálogo
                      },
                      child: Text('Descargar'),
                    ),
                  ],
                );
              },
            );
              },
              child: const Text("Descargar PDF"),
            ),
          ),
        ],
      ),
    );
  }
}
