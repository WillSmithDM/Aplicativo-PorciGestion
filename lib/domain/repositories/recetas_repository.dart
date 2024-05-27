abstract class RecetaRepository {
  Future<String> deleteRecet(String id);
  Future<List<dynamic>> getReceta(String idCamp, String idPigs);
  Future<String> insertRecetDetails(
      String idReceta, String idAlimento,String idPig, String idCamp, Map<String, dynamic> data);
 Future<List<dynamic>> insertRecet(String idcamp);
}
