import 'dart:core';

class Validations {
  static String? campoObligatorio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    }
    return null;
  }

  static String? validarCorreo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (!value.contains('@') || !value.contains('.')) {
      return 'Correo inválido';
    }
    return null;
  }

  static String? validarContrasena(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? soloNumeros(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (double.tryParse(value) == null) {
      return 'Ingrese solo números';
    }
    return null;
  }

  static String? soloLetras(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (!value.replaceAll(' ', '').contains(RegExp(r'^[a-zA-Z]+$'))) {
      return 'Ingrese solo letras';
    }
    return null;
  }

  static String? numerosCelular(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (value.length != 9 || !value.startsWith('9')) {
      return 'Ingrese un número de celular válido (9 dígitos)';
    }
    return null;
  }

  static String? dniPeru(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (value.length != 8 || double.tryParse(value) == null) {
      return 'Ingrese un DNI válido (8 dígitos numéricos)';
    }
    return null;
  }

  static String? numerosDecimales(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo Obligatorio';
    } else if (double.tryParse(value) == null) {
      return 'Ingrese un número decimal válido';
    }
    return null;
  }
}
