abstract class UsersRepository {
  Future<String> deleteUser(String id);
  Future<List<dynamic>>  getUser();
  Future<List<dynamic>>  getUserID(String id);
  //Future<List<Map<dynamic, dynamic>>> getVaccinesGeneral(String idCamp);
  Future<String> insertUsers( Map<String, dynamic> data);
  Future<String> updateUsers(String id,  data);
}
