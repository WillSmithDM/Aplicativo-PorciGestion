import 'package:app_tesis/domain/repositories/dashboard_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_tesis/constants/ip.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  @override
  Future<List<dynamic>> getDatosCant(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}dashboard/cantidad";
      final res = await http.post(Uri.parse(uri), body: {"id_camp": idCamp});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        final List<dynamic> cant = data['body'][0];
        return cant;
      } else {
        throw Exception("Error: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting dashboard: $e");
    }
  }

  @override
  Future<List<dynamic>> getVaccinesDash(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}vacunas/dash";
      final response =
          await http.post(Uri.parse(uri), body: {'idCamp': idCamp});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> vaccinesDash = data['body'][0];
        return vaccinesDash;
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting vaccines: $e");
    }
  }

  @override
  Future<List<dynamic>> getDatoshorizontal(String idCamp) async {
    try {
      const uri = "${ApiConstants.baseUrl}dashboard/horizontal";
      final response =
          await http.post(Uri.parse(uri), body: {"id_camp": idCamp});
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> datares = data['body'][0];
        return datares;
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting dashboard: $e");
    }
  }

  @override
  Future<void> updatePendientes(
      String idCamp, String idPorcino, String idVaccines) async {
    try {
      const uri = "${ApiConstants.baseUrl}dashboard/update";
      final res = await http.post(Uri.parse(uri), body: {
        "id_camp": idCamp,
        "id_pigs": idPorcino,
        "id_vac": idVaccines,
      });
      if (res.statusCode == 200) {
        final response = jsonDecode(res.body);
        if (response["body"] == "success") {
          return;
        } else {
          throw Exception("Error updating vaccines ${response["body"]}");
        }
      } else {
        throw Exception("Error updating vaccines: HTTP ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error updating vaccines http: $e");
    }
  }
}
