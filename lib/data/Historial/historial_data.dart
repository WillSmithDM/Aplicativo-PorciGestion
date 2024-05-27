import 'package:app_tesis/domain/repositories/historial_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../presentation/routes/routess.dart';

class HistorialRepositoryImpl implements HistorialRepository {
  @override
  Future<String> deleteHistorial(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}historial/delete";
      final res = await http.post(Uri.parse(uri), body: {"id": id});
      final respuesta = processResponse(res);
      return respuesta;
    } catch (e) {
      throw Exception("Error deleting campaing: $e");
    }
  }

  @override
  Future<List<dynamic>> getHistorialList(String idCamp, String idPig) async {
    try {
      const uri = "${ApiConstants.baseUrl}historial/";
      final response = await http
          .post(Uri.parse(uri), body: {"id_camp": idCamp, "id_pig": idPig});
      if (response.statusCode == 200) {
        final userdata = jsonDecode(response.body);
        final List<dynamic> data = userdata['body'][0];
        return Future.value(data);
      } else {
        throw Exception("Error HTTP: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al obtener los datos: $e");
    }
  }

  @override
  Future<List<dynamic>> getPig(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}Pigs/";
      final response =
          await http.post(Uri.parse(uri), body: {"id_camp": idCamp});
      if (response.statusCode == 200) {
        final userdata = jsonDecode(response.body);
        final List<dynamic> data = userdata['body'][0];
        return Future.value(data);
      } else {
        throw Exception("Error HTTP: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting campaings: $e");
    }
  }

  @override
  Future<List<dynamic>> getHistorial(
      String idCamp, String idPig, String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}historial/listar";
      final response = await http.post(Uri.parse(uri),
          body: {"id_camp": idCamp, "id_pig": idPig, "id_historial": id});
      if (response.statusCode == 200) {
        final userdata = jsonDecode(response.body);
        final List<dynamic> data = userdata['body'][0];
        return Future.value(data);
      } else {
        throw Exception("Error HTTP: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error al obtener los datos: $e");
    }
  }

  @override
  Future<String> insertHistorial(String idCamp, String idPig, String idUser,
      Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}Historial/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        "camp_id": idCamp,
        "id_porci": idPig,
        "id_user": idUser,
        "obs": data["observaciones"],
        "Enfer": data["Emferm"]
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error HTTP! : $e");
    }
  }

  @override
  Future<String > updateHistorial(
      String id, String idCamp, String idPig, Map<String, dynamic> data) {
    throw UnimplementedError();
  }
}
