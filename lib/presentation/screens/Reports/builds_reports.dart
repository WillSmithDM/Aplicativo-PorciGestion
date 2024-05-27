import 'package:app_tesis/constants/colors.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const ReportCard({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
             Icon(Icons.download, color: MisColores.primary, size: 30,)
          ],
        ),
      ),
    );
  }
}

class ReportDialog extends StatelessWidget {
  final VoidCallback onGeneralDownloadPressed;
  final VoidCallback onSpecificDownloadPressed;

  const ReportDialog({
    required this.onGeneralDownloadPressed,
    required this.onSpecificDownloadPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Elija una opción',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            title: 'Descarga General',
            icon: const Icon(Icons.download),
            onPressed: onGeneralDownloadPressed,
          ),
          SizedBox(height: 10),
          _buildButton(
            title: 'Descarga Específica',
            icon: const Icon(Icons.arrow_forward),
            onPressed: onSpecificDownloadPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required VoidCallback onPressed,
    required Icon icon,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: icon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
