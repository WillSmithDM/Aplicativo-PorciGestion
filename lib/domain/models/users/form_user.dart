import "package:app_tesis/constants/decoration.dart";
import "package:app_tesis/constants/validations.dart";
import "package:flutter/material.dart";

class UserForm extends StatefulWidget {
  final Function(Map<String, dynamic>, bool) onSubmit;
  final String? initialname;
  final String? initialfirstname;
  final String? initialdni;
  final String? initialphone;
  final String? initialEmail;
  final String? initialPass;
  final String? initialUsername;
  final bool isEditing;
  final String? initialRol;

  const UserForm(
      {this.initialname,
      this.initialEmail,
      super.key,
      this.initialRol,
      required this.onSubmit,
      this.initialfirstname,
      this.initialdni,
      this.initialphone,
      this.initialPass,
      this.initialUsername,
      required this.isEditing});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  late TextEditingController name;
  late TextEditingController firstname;
  late TextEditingController dni;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController username;
  late bool _isEditing;
  late String _selectedRol;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  VoidCallback? onPressedCallback;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.initialname ?? '');
    firstname = TextEditingController(text: widget.initialfirstname ?? '');
    dni = TextEditingController(text: widget.initialdni ?? '');
    phone = TextEditingController(text: widget.initialphone ?? '');
    email = TextEditingController(text: widget.initialEmail ?? '');
    password = TextEditingController(text: widget.initialPass ?? '');
    username = TextEditingController(text: widget.initialUsername ?? '');
    _isEditing = widget.isEditing;
    _selectedRol = widget.initialRol ?? '1';
  }

  formItemsDesing(icon, item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.all(12.0),
      decoration: MisDecoraciones.miDecoracion(),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              formItemsDesing(
                Icons.person,
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: Validations.campoObligatorio,
                ),
              ),
              formItemsDesing(
                Icons.person,
                TextFormField(
                  controller: firstname,
                  decoration: const InputDecoration(labelText: 'Apellidos'),
                  validator: Validations.soloLetras,
                ),
              ),
              formItemsDesing(
                Icons.assignment_ind_outlined,
                TextFormField(
                  controller: dni,
                  decoration: const InputDecoration(labelText: 'D.N.I.'),
                  validator: Validations.dniPeru,
                ),
              ),
              formItemsDesing(
                Icons.contact_phone,
                TextFormField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: 'Telefono'),
                  validator: Validations.numerosCelular,
                ),
              ),
              formItemsDesing(
                Icons.email_outlined,
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(labelText: 'Correo'),
                  validator: Validations.validarCorreo,
                ),
              ),
              formItemsDesing(
                Icons.person_pin_circle,
                TextFormField(
                  controller: username,
                  decoration:
                      const InputDecoration(labelText: 'Nombre de Usuario'),
                  validator: Validations.soloLetras,
                ),
              ),
              formItemsDesing(
                Icons.password_outlined,
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  validator: Validations.validarContrasena,
                ),
              ),
              formItemsDesing(
                  Icons.person_pin_circle,
                  DropdownButtonFormField<String>(
                    value: _selectedRol,
                    onChanged: (value) {
                      setState(() {
                        _selectedRol = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value:
                            '1', // Convertir el valor numérico en una cadena de texto
                        child: Text('Administrador'),
                      ),
                      DropdownMenuItem(
                        value:
                            '2', // Convertir el valor numérico en una cadena de texto
                        child: Text('Veterinario'),
                      ),
                      DropdownMenuItem(
                        value:
                            '3', // Convertir el valor numérico en una cadena de texto
                        child: Text('Jefe de Producción'),
                      ),
                      DropdownMenuItem(
                        value:
                            '4', // Convertir el valor numérico en una cadena de texto
                        child: Text('Usuario'),
                      ),
                    ],
                    decoration: InputDecoration(labelText: 'Rol'),
                    validator: (value) =>
                        value == null ? 'Seleccione un rol' : null,
                  )),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final data = {
                      'nombre': name.text,
                      'apellido': firstname.text,
                      'dni': dni.text,
                      'telf': phone.text,
                      'email': email.text,
                      'usuario': username.text,
                      'pass': password.text,
                      'rol': _selectedRol
                    };
                    widget.onSubmit(data, _isEditing);
                  }
                },
                child: Text(_isEditing ? 'Actualizar' : 'Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
