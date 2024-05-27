import 'package:app_tesis/constants/alert_messages.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final Widget leading;
  final String title;
  final String subtitle;
  final String? additionalText;
  final TextStyle? additionalStyle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final void Function()? onTap;
  final void Function()? onEdit;
  final void Function(String)? onDelete;
  final String id; // Nuevo parámetro para almacenar el ID

  const CustomListItem({
    Key? key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.additionalText, // Hacer que additionalText sea opcional
    required this.id, // Agregar ID como un parámetro requerido
    this.titleStyle,
    this.subtitleStyle,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.additionalStyle,
  }) : super(key: key);

  // Métodos de la clase...

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            leading,
            const SizedBox(
              width: 8,
            ),
            Container(
              width: 1, // ajusta el ancho del contenedor según sea necesario
              height: 25, // ajusta la altura del contenedor según sea necesario
              color: Colors.black,
            ),
            const SizedBox(width: 8)
          ],
        ),
        title: Row( // Colocar el título y el texto adicional en la misma fila
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: titleStyle ?? const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  if (additionalText != null) // Mostrar el texto adicional si está presente
                    Text(
                      additionalText!,
                      style: additionalStyle ?? const TextStyle(
                        color: Colors.black, // Color negro por defecto
                        fontSize: 10,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Text(
          subtitle,
          style: subtitleStyle ??
              const TextStyle(
                color: Colors.black,
                fontSize: 11,
              ),
        ),
        onTap: onTap,
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            if (onEdit != null)
              const PopupMenuItem(
                value: 'Editar',
                child: Text('Editar'),
              ),
            if (onDelete != null)
              const PopupMenuItem(
                value: 'Eliminar',
                child: Text('Eliminar'),
              ),
          ],
          onSelected: (String value) {
            // Manejar la opción seleccionada
            switch (value) {
              case 'Editar':
                onEdit?.call();
                break;
              case 'Eliminar':
                AlertMessages.showConfirmation(
                  context,
                  'Eliminar Registro',
                  'Desea Eliminar este registro?',
                  () async {
                    onDelete?.call(id);
                  },
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
