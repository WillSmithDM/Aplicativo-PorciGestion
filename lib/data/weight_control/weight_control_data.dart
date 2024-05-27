import 'package:app_tesis/domain/repositories/controlpeso_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControlRepositoryImpl implements ControlRepository {
  @override
  Future<String> deleteControl(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}pesos/delete";
      final res = await http.post(Uri.parse(uri), body: {"id": id});
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error deleting campaing: $e");
    }
  }

  @override
  Future<List<dynamic>> getControlPesoG(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}pesos/general";
      final res = await http.post(Uri.parse(uri), body: {"id_camp": idCamp});
      if (res.statusCode == 200) {
        final userdata = jsonDecode(res.body);
        final List<dynamic> data = userdata['body'][0];
        return data;
      }else {
        throw Exception("Error HTTP: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting campaings: $e");
    }
  }

  @override
  Future<List<dynamic>> getControlPesoP(
      String idCamp, String idPorcino) async {
    try {
      const uri = "${ApiConstants.baseUrl}pesos/";
      final res = await http.post(Uri.parse(uri),
          body: {"id_camp": idCamp, "id_porci": idPorcino});
      if (res.statusCode == 200) {
        final userdata = jsonDecode(res.body);
        final List<dynamic> data = userdata['body'][0];
        return data;
      }else {
        throw Exception("Error HTTP: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting campaings: $e");
    }
  }

  @override
  Future<String> insertControl(
       data, String idCamp, String idPorcino) async {
    try {
      const uri = "${ApiConstants.baseUrl}pesos/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        "id_porci": idPorcino,
        "camp_id": idCamp,
        "peso": data['peso'],
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error creating campaing: $e");
    }
  }

  @override
  Future<String> updateControl(String idCamp, String idPorcino, String id,
       data) async {
    try {
      const  uri = "${ApiConstants.baseUrl}pesos/update";
      final res = await http.post(
        Uri.parse(uri),
        body: {
          "id_camp": idCamp,
          "id_pigs": idPorcino,
          "id_control": id,
          "peso_por": data['peso']
        },
      );
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error updating control: $e");
    }
  }
}
