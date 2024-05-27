import 'package:app_tesis/domain/repositories/campaing_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CampaingRepositoryImpl implements CampaingRepository {
  @override
  Future<String> deleteCampaing(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}campaing/delete";
      final res = await http.put(Uri.parse(uri), body: {"id": id});
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error deleting campaing: $e");
    }
  }

  @override
Future<List<dynamic>> getCampaings() async {
  try {
    const uri = "${ApiConstants.baseUrl}campaing/";
    final response = await http.get(Uri.parse(uri));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      
      final List<dynamic> campaingsData = data['body'][0];
      return campaingsData;
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error getting campaings: $e");
  }
}



  @override
  Future<String> insertCampaing(
      Map<String, dynamic> data, DateTime startDate, DateTime endDate) async {
    try {
      const uri = "${ApiConstants.baseUrl}campaing/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        "nombre": data['name'],
        "inicio": _formatDate(startDate),
        "final": _formatDate(endDate),
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error creating campaing: $e");
    }
  }

  @override
  Future<String> updateCampaing(Map<String, dynamic> data, DateTime startDate,
      DateTime endDate, String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}campaing/update";
      final res = await http.post(Uri.parse(uri), body: {
        "id": id,
        "nombre": data['name'],
        "inicio": _formatDate(startDate),
        "final": _formatDate(endDate),
        "est": data['status'] == 1 ? '1' : '0',
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error updating campaing: $e");
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
