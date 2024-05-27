import 'dart:io';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

Future<bool> generatePdf(
  List<dynamic> data, BuildContext context) async {
  final pdf = pw.Document();

  if (data.isEmpty) {
    return false;
  } else {
    for (final historia in data) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Ficha Técnica',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      pw.Text(
                        'F.de Descarga: ${DateTime.now().toString().split(' ')[0]}', // Obtener solo la fecha
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Creado por:',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16, // Color verde
                        ),
                      ),
                      pw.Text(
                        '${historia["name"]} ${historia["firstname"]}',
                        style:
                           const  pw.TextStyle(fontSize: 16, color: PdfColors.green),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.only(bottom: 10),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Fecha de Creación:',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      pw.Text(
                        fecha(historia["fech_crea"]),
                        style: const pw.TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.Divider(
                    height: 5,
                    color: PdfColors.black,
                    borderStyle: pw.BorderStyle.dashed), // Separador
                pw.SizedBox(height: 10),
                pw.Text(
                  'Nombre de la Historia:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  historia["nombre_historial"],
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(height: 4, color: PdfColors.grey),
                pw.SizedBox(height: 10),

                pw.Text(
                  'Código del Porcino:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  historia["codigo"],
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(height: 4, color: PdfColors.grey),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Peso del Porcino:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  "${historia["peso_actual"].toString()} Kg" ,
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(height: 4, color: PdfColors.grey),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Vacunas Realizadas:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  historia["vacunas"],
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Divider(height: 4, color: PdfColors.grey),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Enfermedades:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  historia["enfermedades"],
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  'Observaciones:',
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                pw.Text(
                  historia["observacion"],
                  style: const pw.TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    try {
      // Obtener el directorio de almacenamiento externo
      final directory = await getExternalStorageDirectory();
      if (directory == null) {
        throw Exception(
            'No se pudo acceder al directorio de almacenamiento externo');
      }

      final downloadsDirectory = Directory('${directory.path}/Download');
      if (!await downloadsDirectory.exists()) {
        await downloadsDirectory.create(recursive: true);
      }

      final path =
          '${downloadsDirectory.path}/HistorialClinico_${DateTime.now().toString().replaceAll(RegExp(r'\D'), '')}.pdf'; // Nombre del archivo basado en la fecha y hora de descarga

      // Guardar el PDF
      final File file = File(path);
      await file.writeAsBytes(await pdf.save());

      // Mostrar un mensaje de éxito
      return true;
    } catch (e) {
      // Mostrar un mensaje de error
      return false;
    }
  }
}
