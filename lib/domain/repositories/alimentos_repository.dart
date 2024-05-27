abstract class AlimentosRepository {
  Future<String> deleteAlimentos(String id);
 Future<List<dynamic>>  getAlimentos(String idCamp);
  //Future<List<Map<dynamic, dynamic>>> getVaccinesGeneral(String idCamp);
  Future<String> insertAlimentos(String idCamp, Map<String, dynamic> data);
  Future<String> updateAlimentos(String id, String idCamp, Map<String, dynamic> data);
}
