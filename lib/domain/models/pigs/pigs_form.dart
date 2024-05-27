import 'package:app_tesis/constants/decoration.dart';
import 'package:app_tesis/constants/validations.dart';
import 'package:flutter/material.dart';

class FormPigs extends StatefulWidget {
  final Function(Map<String, dynamic>, bool) onSubmit;
  final String? initialCod;
  final String? initialPesoI;
  final String? initialCoste;
  final bool isEditing;

  const FormPigs(
      {required this.onSubmit,
      this.initialCod,
      this.initialCoste,
      this.initialPesoI,
      required this.isEditing,
      super.key});

  @override
  State<FormPigs> createState() => _FormPigsState();
}

class _FormPigsState extends State<FormPigs> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codController;
  late TextEditingController _pesoInicialController;

  late TextEditingController _costeController;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    _codController = TextEditingController(text: widget.initialCod ?? '');
    _costeController = TextEditingController(text: widget.initialCoste ?? '');
    _pesoInicialController =
        TextEditingController(text: widget.initialPesoI ?? '');
    _isEditing = widget.isEditing;
  }

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(12.0),
      decoration: MisDecoraciones.miDecoracion(),
      child: Form(
        key: _formKey,
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  textCapitalization: TextCapitalization.characters,
                  keyboardType: TextInputType.number,
                  controller: _codController,
                  decoration: const InputDecoration(labelText: "Código"),
                  validator: Validations.campoObligatorio,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: TextFormField(
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          controller: _pesoInicialController,
                          decoration:
                              const InputDecoration(labelText: "Peso Inicial"),
                          validator: Validations.campoObligatorio,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        child: TextFormField(
                          textCapitalization: TextCapitalization.characters,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          controller: _costeController,
                          decoration:
                              const InputDecoration(labelText: "Coste"),
                          validator: Validations.campoObligatorio,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = {
                            'codigo': _codController.text,
                            'Pinicial': _pesoInicialController.text,
                            'Coste': _costeController.text
                          };
                          widget.onSubmit(data, _isEditing);
                        }
                      },
                      child: Text(_isEditing ? 'Actualizar' : 'Guardar'),
                    ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
