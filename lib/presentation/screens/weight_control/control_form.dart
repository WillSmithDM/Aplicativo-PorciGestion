import 'package:flutter/material.dart';

class DialogForm extends StatefulWidget {
  final Function(Map<String, dynamic>, bool) onSubmit;
  final bool isEditing;
  final String? initialWeight;

  const DialogForm({
    required this.onSubmit,
    this.initialWeight,
    super.key,
    required this.isEditing,
  });

  @override
  _DialogFormState createState() => _DialogFormState();
}

class _DialogFormState extends State<DialogForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool _isEditing;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: widget.initialWeight ?? '');
    _isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? "Editar Peso" : "Ingresar Nuevo Peso"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: weightController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Peso(Kg)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el peso';
                }
                // Utiliza una expresión regular para verificar si el valor es numérico
                if (!RegExp(r'^\d*\.?\d+$').hasMatch(value)) {
                  return 'Ingrese un valor numérico válido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Valida el formulario
              final data = {'peso': weightController.text};
              widget.onSubmit(data, _isEditing);
              Navigator.pop(context);
            }
          },
          child: Text(_isEditing ? 'Editar' : 'Guardar'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }
}
