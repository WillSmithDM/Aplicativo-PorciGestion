import 'package:app_tesis/presentation/routes/routess.dart';

class PerfilUsuario extends StatefulWidget {
  static String id = "Perfil_id";
  final GlobalKey<NavigatorState> navigatorKey;
  final VoidCallback onLogout;
  final VoidCallback changeCamaping;
  const PerfilUsuario(
      {super.key,
      required this.navigatorKey,
      required this.onLogout,
      required this.changeCamaping});

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  late Future<List<dynamic>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = UserRepositoryImpl().getUserID(UserID.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: _userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final userData = snapshot.data!;
              return SingleChildScrollView(
                child: _buildProfile(userData),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfile(List<dynamic> userData) {
    final user = userData.isNotEmpty ? userData[0] : {};

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display user avatar or image
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('res/user3.png'),
              ),
              const SizedBox(height: 20),
              // Display user's name and other details
              Text(
                '${user['name'] ?? 'Nombre no disponible'}  ${user['firstname']}',
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                user['dni'] ?? 'DNI no disponible',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 25),
              // Display user's contact information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Correo : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MisColores.primary),
                      ),
                      Text(user['email'] ?? 'Correo no disponible'),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'Telefono : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MisColores.primary),
                      ),
                      Text(user['phone'] ?? 'Teléfono no disponible'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Display user's company information
              const Card(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'I.E.S.T.P - SULLANA',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'RUC : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MisColores.primary),
                      ),
                      subtitle: Text('20141460910'),
                    ),
                    ListTile(
                      title: Text(
                        'Dirección',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MisColores.primary),
                      ),
                      subtitle: Text('Cieneguillo Centro Km. 06'),
                    ),
                    ListTile(
                      title: Text(
                        'Teléfono : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MisColores.primary),
                      ),
                      subtitle: Text('Teléfono no disponible'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Button to logout
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showLogoutConfirmationDialog(context);
                    },
                    child: const Text('Cerrar Sesión'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.changeCamaping();
                    },
                    child: const Text('Cambiar Campaña'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                UserID.id = '';
                RolID.id = '';
                CampaingId.id = '';
                widget.onLogout();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}
