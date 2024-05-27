import 'package:app_tesis/domain/repositories/pigs_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_tesis/presentation/routes/routess.dart';

class PigsRepositoryImpl implements PigsRepository {
  @override
  Future<Set<String>> getPigCodes(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}Pigs/";
      final response =
          await http.post(Uri.parse(uri), body: {"id_camp": idCamp});
      final pigsData = jsonDecode(response.body) as List<dynamic>;
      final pigCodes = pigsData.map((pig) => pig['codigo'] as String).toSet();
      return pigCodes;
    } catch (e) {
      throw Exception("Error getting pig codes: $e");
    }
  }

  @override
  Future<String> deletePigs(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}Pigs/delete";
      final res = await http.put(Uri.parse(uri), body: {"id": id});
      final respuet =processResponse(res);
      return respuet;
    } catch (e) {
      throw Exception("Error : $e ");
    }
  }

  @override
  Future<List<dynamic>> getPigs(String idCamp) async {
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
      throw Exception("Error : $e");
    }
  }

  @override
  Future<String> insertPigs(String idCamp, Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}Pigs/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        "camp_id": idCamp,
        "codigo": data['codigo'],
        "pinicial": data["Pinicial"],
        "coste": data["Coste"]
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error creating campaing: $e");
    }
  }

  @override
  Future<String> updatePigs(
      String idCamp, String id, Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}Pigs/update";
      final res = await http.post(Uri.parse(uri), body: {
        "camp_id": idCamp,
        "id": id,
        "codigo": data['codigo'],
        "pinicial": data["Pinicial"],
        "coste": data["Coste"]
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error update campaing: $e");
    }
  }
}
