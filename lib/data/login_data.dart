import 'package:app_tesis/domain/repositories/login_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_tesis/constants/ip.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      const uri = "${ApiConstants.baseUrl}auth/login";
      final response = await http.post(Uri.parse(uri),
          body: {"usuario": username, "password": password});
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = responseData['body']['token'];
        final userData = responseData['body']['userData'];
        return {'token': token, 'userData': userData};
      } else if (response.statusCode  == 210) {
        return {'error': 'Credenciales incorrectas'};
      }else {
        throw Exception("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
