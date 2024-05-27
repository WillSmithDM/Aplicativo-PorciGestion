import 'package:app_tesis/constants/colors.dart';
import 'package:app_tesis/constants/validations.dart';
import 'package:flutter/material.dart';

class FoodsForm extends StatefulWidget {
  final Function(Map<String, dynamic>, bool) onSubmit;
  final bool isEditing;
  final String? initialnombre;
  final String? cantidad;
  final String? peso;
  final String? precio;
  final String? porcentaje;
  const FoodsForm({
    Key? key,
    required this.onSubmit,
    required this.isEditing,
    this.initialnombre,
    this.cantidad,
    this.peso,
    this.precio,
    this.porcentaje,
  }) : super(key: key);

  @override
  State<FoodsForm> createState() => _FoodsFormState();
}

class _FoodsFormState extends State<FoodsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _cantidadController;
  late TextEditingController _proveController;
  late TextEditingController _precioController;
  late TextEditingController _porcentajeController;
  late bool _isEditing;

  @override
  void initState() {
    _nombreController =
        TextEditingController(text: widget.initialnombre ?? '');
    _cantidadController =
        TextEditingController(text: widget.cantidad ?? '');
    _proveController = TextEditingController(text: widget.peso ?? '');
    _precioController = TextEditingController(text: widget.precio ?? '');
    _porcentajeController =
        TextEditingController(text: widget.porcentaje ?? '');
    _isEditing = widget.isEditing;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MisColores.primary,
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          color:MisColores.fondo // Cambia al color que desees
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de Alimento',
                    icon: Icon(Icons.food_bank),
                  ),
                  validator: (value) => Validations.soloLetras(value),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _cantidadController,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese cantidad por total x Kg.',
                    icon: Icon(Icons.high_quality),
                  ),
                  validator: (value) => Validations.numerosDecimales(value),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _proveController,
                  decoration: const InputDecoration(
                    labelText: 'Ingrese Proveedor',
                    icon: Icon(Icons.line_weight),
                  ),
                  validator: (value) => Validations.soloLetras(value),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _precioController,
                  decoration: InputDecoration(
                    labelText: 'Ingrese Precio por Kg.',
                    icon: Icon(Icons.monetization_on),
                  ),
                  validator: (value) =>Validations.numerosDecimales(value),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  validator: (value) => Validations.numerosDecimales(value),
                  controller: _porcentajeController,
                  decoration: InputDecoration(
                    labelText: 'Ingrese porcentaje de proteina por Kg.',
                    icon: Icon(Icons.percent_rounded),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          'nombre': _nombreController.text,
                          'cant': _cantidadController.text,
                          'proveedor': _proveController.text,
                          'precio': _precioController.text,
                          'porc_proteina': _porcentajeController.text,
                        };
                        widget.onSubmit(data, _isEditing);
                      }
                    },
                    child: Text(_isEditing ? 'Actualizar' : 'Guardar'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ), // Agregar espacio al final del formulario
              ],
            ),
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadController.dispose();
    _proveController.dispose();
    _precioController.dispose();
    _porcentajeController.dispose();
    super.dispose();
  }
}
