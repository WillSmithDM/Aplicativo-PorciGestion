import 'package:app_tesis/constants/colors.dart';
import 'package:flutter/material.dart';

class MisDecoraciones {
  static BoxDecoration miDecoracion() {
    return const BoxDecoration(
      color: MisColores.fondo,
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.grey),
      ),
    );
  }
}

class AppBarWidget {
  static AppBar appBar(String title) {
    return AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: MisColores.primary);
  }
}

class SizeBoxWidget {
  static SizedBox sizedBox(String title) {
    
    return SizedBox(
      height:  35,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MisColores.primary
          ),
        ),
      ),
    );
  }
}
