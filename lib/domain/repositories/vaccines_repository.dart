abstract class VaccinesRepository {
  Future<String> deleteVaccines(String id);
  Future<List<dynamic>> getVaccines(String idCamp, String idPigs);
  
  Future<List<dynamic>> getVaccinesGeneral(String idCamp);
  Future<String> insertVaccines(String idCamp, String idPigs, Map<String, dynamic> data);
  Future<String> updateVaccines(String id, Map<String, dynamic> data);
}
