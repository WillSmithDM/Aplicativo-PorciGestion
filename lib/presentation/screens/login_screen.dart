import 'package:animate_do/animate_do.dart';
import 'package:app_tesis/constants/alert_messages.dart';
import 'package:app_tesis/constants/colors.dart';
import 'package:app_tesis/constants/globals_keys.dart';
import 'package:app_tesis/presentation/widgets/Login/login_presenter.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "Login_id";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements LoginViewContract {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  late LoginPresenter _presenter;

  @override
  void initState() {
    super.initState();
    _presenter = LoginPresenter(this);
  }

  Future<bool> _onWillPop() async {
    // Mostrar diálogo de confirmación antes de salir del app
    bool exitConfirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Salir de la aplicación?'),
          content: const Text(
              '¿Estás seguro de que quieres salir de la aplicación?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // No confirmar la salida del app
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirmar la salida del app
              },
              child: Text('Salir'),
            ),
          ],
        );
      },
    );
    return exitConfirmed;
  }

  void _login() {
    final user = username.text;
    final pass = password.text;
    if (user.isEmpty || pass.isEmpty) {
      // Mostrar mensaje de error si los campos están vacíos
      AlertMessages.alertErrors(
          context, 'Por favor ingresa usuario y contraseña.');
      return;
    }
    _presenter.login(user, pass);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 225, 235),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      height: 400,
                      width: width + 20,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('res/1.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1700),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MisColores.blanco,
                            border: Border.all(
                                color: const Color.fromRGBO(196, 135, 198, .3)),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Color.fromRGBO(
                                              196, 135, 198, .3)))),
                              child: TextField(
                                controller: username,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Usuario",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade700)),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Contraseña",
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade700)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1900),
                      child: MaterialButton(
                        onPressed: _login,
                        color: const Color.fromARGB(255, 167, 129, 142),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Iniciar Sesión",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onLoadLoginComplete(id, rolid, message, name) {
    if (mounted) {
      AlertMessages.alertSuccess(context, message);
      UserID.id = id;
      RolID.id = rolid;
      Username.name = name;
    }

    // Reemplaza todas las rutas en la pila de navegación con la pantalla de selección de campaña
    Navigator.pushReplacementNamed(context, '/Select');
  }

  @override
  void onLoadLoginError(message) {
    AlertMessages.alertErrors(context, message);
  }
}
