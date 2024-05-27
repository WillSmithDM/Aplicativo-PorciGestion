import 'package:app_tesis/domain/repositories/recetas_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecetRepositoryImpl implements RecetaRepository {
  @override
  Future<String> deleteRecet(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}recetas/delete";
      final res = await http.post(Uri.parse(uri), body: {"id": id});
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error delete recet: $e");
    }
  }

  @override
  Future<List<dynamic>> getReceta(String idCamp, String idPigs) async {
    try {
      const uri = "${ApiConstants.baseUrl}recetas/";
      final response = await http
          .post(Uri.parse(uri), body: {'id_camp': idCamp, 'id_pig': idPigs});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> userdata = data['body'][0];
        return Future.value(userdata);
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Errror HTTP: $e');
    }
  }

  @override
  Future<List<dynamic>> insertRecet(String idcamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}recetas/agregar";
      final response =
          await http.post(Uri.parse(uri), body: {'id_camp': idcamp});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> userdata = data['body'][0];
        return Future.value(userdata);
      } else {
        throw Exception("Error HTTP: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error get recet : $e");
    }
  }

  @override
  Future<String> insertRecetDetails(String idReceta, String idAlimento,
      String idPig, String idCamp, data) async {
    try {
      const uri = "${ApiConstants.baseUrl}recetas/agregardetails";
      final res = await http.post(Uri.parse(uri), body: {
        'id_receta': idReceta.toString(),
        'id_alimento': idAlimento.toString(),
        'id_pig': idPig.toString(),
        'id_camp': idCamp.toString(),
        'cant': data["cantidad"].toString(),
        'porcentaje': data["porcentaje"].toString()
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error Details Recet HTTP : $e");
    }
  }
}
