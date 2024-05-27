abstract class HistorialRepository {
  Future<String> deleteHistorial(String id);
  Future<List<dynamic>> getPig(String idCamp);
  Future<List<dynamic>>  getHistorialList(String idCamp, String idPig);
  Future<List<dynamic>>  getHistorial(String idCamp, String idPig, String id);
  Future<String> insertHistorial(String idCamp, String idPig, String idUser, Map<String, dynamic> data);
  Future<String> updateHistorial(String id, String idCamp, String idPig, Map<String, dynamic> data);
}
