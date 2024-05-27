import 'package:app_tesis/domain/repositories/alimentos_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlimentosRepositoryImpl implements AlimentosRepository {
  @override
  Future<String> deleteAlimentos(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}alimentos/delete";
      final res = await http.put(Uri.parse(uri), body: {"id": id});
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error deleting foods: $e");
    }
  }

  @override
  Future<List<dynamic>> getAlimentos(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}alimentos/";
      final response =
          await http.post(Uri.parse(uri), body: {"idCamp": idCamp});
      if (response.statusCode == 200) {
        final userdata = jsonDecode(response.body);
        final List<dynamic> data = userdata['body'][0];
        return Future.value(data);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting foods: $e");
    }
  }

  @override
  Future<String> insertAlimentos(
      String idCamp, Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}alimentos/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        'id_camp': idCamp,
        "nombre": data['nombre'],
        "cant": data["cant"],
        'proveedor': data["proveedor"],
        "precio": data["precio"],
        "porc_prote": data["porc_proteina"]
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error updating foods: $e");
    }
  }

  @override
  Future<String> updateAlimentos(
      String id, String idCamp, Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}alimentos/update";
      final res = await http.post(Uri.parse(uri), body: {
        'id': id,
        'idCamp': idCamp,
        "nombre": data['nombre'],
        "cant": data["cant"],
        'proveedor': data["proveedor"],
        "precio": data["precio"],
        "porc_prote": data["porc_proteina"]
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error updating foods: $e");
    }
  }
}
