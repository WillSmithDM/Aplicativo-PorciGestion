import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarForm extends StatefulWidget {
  final Function(Map<String, dynamic>, bool) onSubmit;
  final bool isEditing;
  final String? inititialName;
  final DateTime? initialDate;

  const CalendarForm(
      {Key? key,
      required this.onSubmit,
      required this.isEditing,
      this.inititialName,
      this.initialDate})
      : super(key: key);

  @override
  State<CalendarForm> createState() => _CalendarFormState();
}

class _CalendarFormState extends State<CalendarForm> {
  late TextEditingController _vaccinesController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;
  late bool _isEditing;

  @override
  void initState() {
    _focusedDay = widget.initialDate ?? DateTime.now();
    _vaccinesController =
        TextEditingController(text: widget.inititialName ?? '');
    _isEditing = widget.isEditing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            locale: 'es_ES',
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_focusedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = selectedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _vaccinesController,
              decoration: const InputDecoration(
                labelText: 'Ingrese Nombre de la vacuna',
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_vaccinesController.text.isNotEmpty) {
                  final data = {
                    'vacuna': _vaccinesController.text,
                    'fecha_vacuna': _focusedDay.toIso8601String(),
                  };
                  widget.onSubmit(data, _isEditing);
                }
              },
              child: Text(_isEditing ? 'Editar' : 'Guardar'),
            ),
          )
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _vaccinesController.dispose();
    super.dispose();
  }
}
