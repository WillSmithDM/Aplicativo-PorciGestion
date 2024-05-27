import 'dart:convert';
import 'package:app_tesis/domain/repositories/user_repository.dart';
import 'package:app_tesis/presentation/routes/routess.dart';
import 'package:http/http.dart ' as http;

class UserRepositoryImpl implements UsersRepository {
  @override
  Future<String> deleteUser(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}usuarios/delete";
      final res = await http.post(Uri.parse(uri), body: {"id": id});
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error http : $e");
    }
  }

  @override
  Future<List<dynamic>> getUser() async {
    try {
      const uri = "${ApiConstants.baseUrl}usuarios/";
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body)["body"][0];
        print(userData);
        return userData;
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting user: $e");
    }
  }

  @override
  Future<String> insertUsers(Map<String, dynamic> data) async {
    try {
      const uri = "${ApiConstants.baseUrl}usuarios/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        "name": data["nombre"].toString(),
        "firstname": data["apellido"],
        "dni": data["dni"].toString(),
        "phone": data["telf"].toString(),
        "email": data["email"],
        "est": 1.toString(),
        "usuario": data["usuario"],
        "password": data["pass"],
        "rol_id": data["rol"].toString(),
      });
      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      throw Exception("Error http: $e ");
    }
  }

  @override
  Future<String> updateUsers(String id, data) async {
    try {
      const uri = "${ApiConstants.baseUrl}usuarios/agregar";
      final res = await http.post(Uri.parse(uri), body: {
        "id": id,
        "name": data["nombre"].toString(),
        "firstname": data["apellido"],
        "dni": data["dni"].toString(),
        "phone": data["telf"].toString(),
        "email": data["email"],
        "username": data["usuario"],
        "password": data["pass"],
        "est": 1.toString(),
        "rol_id": data["rol"].toString()
      });

      final respuest = processResponse(res);
      return respuest;
    } catch (e) {
      print("actu error http: $e");
      throw Exception("Error HTTP : $e");
    }
  }

  @override
  Future<List<dynamic>> getUserID(String id) async {
    try {
      const uri = "${ApiConstants.baseUrl}usuarios/userid";
      final response = await http.post(Uri.parse(uri), body: {"id": id});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final  List<dynamic> userdata = data['body'][0];
        return  Future.value(userdata);
      } else {
        throw Exception("Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error getting user: $e");
    }
  }
}
