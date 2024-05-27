import 'package:app_tesis/constants/colors.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class AlertMessages {
  static void alertInfo(BuildContext context, String message) {
    AnimatedSnackBar.material(message,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            duration: const Duration(seconds: 5),
            desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
            type: AnimatedSnackBarType.info)
        .show(context);
  }

  static void alertDelete(BuildContext context, String message) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: message,
      confirmBtnText: 'Aceptar',
    );
  }

  static void alertSuccess(BuildContext context, String message) {
    AnimatedSnackBar.material(message,
            mobileSnackBarPosition: MobileSnackBarPosition.top,
            duration: const Duration(seconds: 5),
            desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
            type: AnimatedSnackBarType.success)
        .show(context);
  }

  static void alertErrors(BuildContext context, String message) {
    AnimatedSnackBar.material(message,
            animationCurve: Curves.bounceIn,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom,
            duration: const Duration(seconds: 5),
            desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
            type: AnimatedSnackBarType.error)
        .show(context);
  }

  static void alertinfo(BuildContext context, String messages) {
    final snackBar = AnimatedSnackBar.material(messages,
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        duration: const Duration(seconds: 3),
        desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
        type: AnimatedSnackBarType.info);
    snackBar.show(context);
    Navigator.of(context, rootNavigator: true)
        .pop('dialog'); // Cierra la alerta después de 2 segundos;
  }

  static void showConfirmation(BuildContext context, String title,
      String message, VoidCallback onConfirm) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: title,
      text: message,
      cancelBtnText: "Cancelar",
      confirmBtnText: 'Aceptar',
      onConfirmBtnTap: () async {
        try {
          onConfirm();
          Navigator.of(context, rootNavigator: true).pop('dialog');
        } catch (e) {
          AlertMessages.alertInfo(context, 'Error al realizar esta acción');
        } // Maneja el error si ocurre un error durante la acci    const Duration(milliseconds: 1000)); // Espera un poco
      },
    );
  }
}

class DataCarga {
  static Widget loading() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoActivityIndicator(
          color: MisColores.primary,
          radius: 25,
        ),
        SizedBox(height: 10), // Espacio entre el indicador y el texto
        Text(
          "Loading",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
