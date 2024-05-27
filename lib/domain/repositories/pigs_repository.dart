abstract class PigsRepository {
  Future<String> deletePigs(String id);
  Future<List<dynamic>> getPigs(String idCamp);
  Future<Set<String>> getPigCodes(String idCamp);
  Future<String> insertPigs(String idCamp, Map<String, dynamic> data);
  Future<String> updatePigs(String idCamp, String id,Map<String, dynamic> data);
}
