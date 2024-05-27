import 'package:flutter/material.dart';

class DropdownDialog extends StatelessWidget {
  final Set<String> options; // Cambiado a Set en lugar de List
  final String selectedOption;
  final ValueChanged onChanged;
  final VoidCallback onAccept;
  final VoidCallback onCancel;

  const DropdownDialog({
    Key? key, // Corregido el parámetro key
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    required this.onAccept,
    required this.onCancel,
  }) : super(key: key); // Añadido super(key: key) al constructor

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccione una opción'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: selectedOption,
            onChanged: onChanged,
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onAccept,
                child: const Text('Aceptar'),
              ),
              ElevatedButton(
                onPressed: onCancel,
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
