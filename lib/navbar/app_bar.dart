import 'package:app_tesis/constants/globals_keys.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Coloca aquí el ID de usuario
    final String userName = Username.name!; // Nombre de usuario predeterminado

    return AppBar(
      backgroundColor: const Color.fromARGB(255, 148, 0, 255),
      elevation: 0,
      title: Text(
        'Hola! $userName', // Muestra el nombre del usuario
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            print('Icono de Notificaciones presionado');
          },
          icon: const Icon(
            Icons.notifications_active_outlined,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }
}
