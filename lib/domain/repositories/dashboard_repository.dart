abstract class DashboardRepository {
  Future<List<dynamic>> getVaccinesDash(String idCamp);
  Future<List<dynamic>> getDatosCant(String idCamp);
  Future<List<dynamic>> getDatoshorizontal(String idCamp);
  Future<void> updatePendientes( String idCamp, String idPorcino, String idVaccines);

}
