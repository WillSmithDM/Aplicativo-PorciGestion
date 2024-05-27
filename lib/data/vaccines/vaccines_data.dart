import 'package:app_tesis/domain/repositories/vaccines_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VaccinesRepositoryImpl implements VaccinesRepository {
  @override
  Future<String> deleteVaccines(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}vacunas/delete";
      final res = await http.post(Uri.parse(uri), body: {"id": id});
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error deleting vaccines: $e");
    }
  }

  @override
  Future<List<dynamic>> getVaccines(String idCamp, String idPigs) async {
    try {
      const uri = "${ApiConstants.baseUrl}vacunas/";
      final response = await http
          .post(Uri.parse(uri), body: {'id_camp': idCamp, 'id_pigs': idPigs});
      if (response.statusCode == 200) {
        final userdata = jsonDecode(response.body);
        final List<dynamic> data = userdata['body'][0];
        return Future.value(data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting vaccines: $e");
    }
  }

  @override
  Future<List<dynamic>> getVaccinesGeneral(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}vacunas/general";
      final response =
          await http.post(Uri.parse(uri), body: {'id_camp': idCamp});
  if (response.statusCode == 200) {
    final userdata = jsonDecode(response.body);
        final List<dynamic> data = userdata['body'][0];
        return Future.value(data);
  }else {
    throw Exception("Error: ${response.statusCode}");
  }
    } catch (e) {
      throw Exception("Error getting vaccines: $e");
    }
  }

  @override
  Future<String> insertVaccines(
      String idCamp, String idPigs, Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}vacunas/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        'id_camp': idCamp,
        'id_pigs': idPigs,
        'n_vacuna': data['vacuna'],
        'fecha_vacuna': data['fecha_vacuna']
      });
      final respuet = processResponse(res);
      return respuet;
    } catch (e) {
      throw Exception("Error creating vaccines: $e");
    }
  }

  @override
  Future<String> updateVaccines(String id, Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}vacunas/update";
      final res = await http.post(Uri.parse(uri), body: {
        "id_vaccines": id,
        "n_vacuna": data['vacuna'],
        "fecha_vacuna": data["fecha_vacuna"]
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error updating vaccines: $e");
    }
  }
}
