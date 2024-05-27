abstract class CampaingRepository {
  Future<String> deleteCampaing(String id);
  Future<List<dynamic>>  getCampaings();
  Future<String> insertCampaing(
      Map<String, dynamic> data, DateTime startDate, DateTime endDate);
    Future<String> updateCampaing(Map<String, dynamic> data, DateTime startDate, DateTime endDate, String id);
}
