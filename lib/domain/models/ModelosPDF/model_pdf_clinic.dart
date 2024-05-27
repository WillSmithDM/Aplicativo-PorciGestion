import 'dart:io';
import 'package:app_tesis/presentation/routes/routess.dart';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> generarYDescargarPDF(
    BuildContext context,
    String title,
    String text1,
    String text2,
    String text3,
    String text4,
    String text5) async {
  final pdf = pw.Document();

  // Estilo de texto para el título
  final pw.TextStyle titleStyle = pw.TextStyle(
    fontSize: 28,
    fontWeight: pw.FontWeight.bold,
  );

  // Estilo de texto para los subtítulos
  final pw.TextStyle subtitleStyle = pw.TextStyle(
    fontSize: 20,
    fontWeight: pw.FontWeight.bold,
  );

  // Estilo de texto para los datos
  final pw.TextStyle dataStyle = pw.TextStyle(
    fontSize: 18,
  );

  // Agregar página al PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Container(
          padding: pw.EdgeInsets.all(20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Título
              pw.Text(
                ' $title',
                style: titleStyle,
              ),
              pw.SizedBox(height: 20),
              // Fecha de Realización
              pw.Text(
                'Fecha de Realización:',
                style: subtitleStyle,
              ),
              pw.Text(
                text1,
                style: dataStyle,
              ),
              pw.Divider(height: 6),
              // Porcino
              pw.Text(
                'Porcino:',
                style: subtitleStyle,
              ),
              pw.Text(
                text2,
                style: dataStyle,
              ),
              pw.Divider(height: 6),
              // Peso Actual
              pw.Text(
                'Peso Actual:',
                style: subtitleStyle,
              ),
              pw.Text(
                text3,
                style: dataStyle,
              ),
              pw.Divider(height: 6),
              // Vacunas Realizadas hoy
              pw.Text(
                'Vacunas Realizadas hoy:',
                style: subtitleStyle,
              ),
              pw.Text(
                text4,
                style: dataStyle,
              ),
              pw.Divider(height: 6),
              // Observaciones
              pw.Text(
                'Observaciones:',
                style: subtitleStyle,
              ),
              pw.Text(
                text5,
                style: dataStyle,
              ),
            ],
          ),
        );
      },
    ),
  );

  try {
    // Obtener el directorio de almacenamiento externo
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw Exception('No se pudo acceder al directorio de almacenamiento externo');
    }

    final downloadsDirectory = Directory('${directory.path}/Download');
    if (!await downloadsDirectory.exists()) {
      await downloadsDirectory.create(recursive: true);
    }

    final path = '${downloadsDirectory.path}/$title.pdf'; // Nombre del archivo basado en el título

    // Guardar el PDF
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    // Mostrar un mensaje de éxito
    AlertMessages.alertSuccess(context, 'Descarga Exitosa');
  } catch (e) {
    // Mostrar un mensaje de error
    AlertMessages.alertErrors(context, 'Error al descargar el PDF: $e');
  }
}
