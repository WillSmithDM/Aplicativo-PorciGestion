import 'package:app_tesis/constants/decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class MyForm extends StatefulWidget {
  final Function(Map<String, dynamic>, bool) onSubmit;
  final Function(DateTime) onStartDateSelected;
  final Function(DateTime) onEndDateSelected;
  final bool isEditing;
  final String? initialStatus;
  final String? initialName;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  const MyForm({
    super.key,
    required this.onSubmit,
    required this.onStartDateSelected,
    required this.onEndDateSelected,
    required this.isEditing,
    this.initialStatus,
    this.initialName,
    this.initialStartDate,
    this.initialEndDate,
  });

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late DateTime _startDate;
  late DateTime _endDate;
  late String _status;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _startDate = widget.initialStartDate ?? DateTime.now();
    _endDate = widget.initialEndDate ?? DateTime.now();
    _status = widget.initialStatus ?? "Activo";
    _isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: MisDecoraciones.miDecoracion(),
      child: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (_isEditing)
                  DropdownButtonFormField<String>(
                    value: _status, // El valor actual del estado
                    items: ['Activo', 'Culminar'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _status =
                            value!; // Actualizamos el estado con el nuevo valor seleccionado
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Estado'),
                  ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectStartDate(context);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de Inicio',
                            hintText: 'Seleccionar fecha',
                          ),
                          child: Text("${_formatDate(_startDate)}"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _selectEndDate(context);
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Fecha de Fin',
                            hintText: 'Seleccionar fecha',
                          ),
                          child: Text("${_formatDate(_endDate)}"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          'name': _nameController.text,
                          'status': _status == 'Activo' ? 1 : 2,
                          'start_date': _startDate.toIso8601String(),
                          'end_date': _endDate.toIso8601String(),
                        };
                        widget.onSubmit(data, _isEditing);
                      }
                    },
                    child: Text(_isEditing ? 'Actualizar' : 'Guardar'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2101),
      currentTime: _startDate,
      locale: LocaleType.es,
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        widget.onStartDateSelected(
            picked); // Actualiza la fecha seleccionada en el formulario padre
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2101),
      currentTime: _endDate,
      locale: LocaleType.es,
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        widget.onEndDateSelected(
            picked); // Actualiza la fecha seleccionada en el formulario padre
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
