abstract class ControlRepository {
  Future<String> deleteControl(String id);
  Future<List< dynamic>> getControlPesoG(String idCamp);
  Future<List< dynamic>> getControlPesoP(
      String idCamp, String idPorcino);
  Future<String> insertControl(
       data, String idCamp, String idPorcino);
  Future<String> updateControl( String idCamp, String idPorcino, String id,  data);
}
