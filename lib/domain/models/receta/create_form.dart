import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FormReceta extends StatefulWidget {
  final List<String> pigsList;
  final List<String> foodList;
  final Function(Map<String, dynamic>, bool) onSubmitfoods;
  final Function(Map<String, dynamic>, bool) onSubmitrecet;

  const FormReceta(
      {super.key,
      required this.onSubmitfoods,
      required this.pigsList,
      required this.foodList,
      required this.onSubmitrecet});

  @override
  _FormRecetaState createState() => _FormRecetaState();
}

class _FormRecetaState extends State<FormReceta> {
  String? selectedPigs;
  String? selectedValue;
  TextEditingController _textEditingController = TextEditingController();
  List<String> savedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField2<String>(
                    dropdownStyleData: const DropdownStyleData(maxHeight: 200),
                    isExpanded: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    hint: Text(
                      'Seleccionar',
                      style: TextStyle(fontSize: 14),
                    ),
                    items: widget.pigsList
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                        .toList(),
                    value: selectedPigs,
                    onChanged: (value) {
                      setState(() {
                        selectedPigs = value;
                      });
                    },
                    onSaved: (value) {
                      selectedPigs = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detalles',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: _showAddItemDialog,
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: savedItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(savedItems[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar elemento'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField2<String>(
                  dropdownStyleData: const DropdownStyleData(maxHeight: 200),
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  hint: Text(
                    'Seleccionar',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: widget.foodList
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  onSaved: (value) {
                    selectedValue = value;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Ingrese texto',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: _saveItem,
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _saveItem() {
    String selectedItem = selectedValue ?? '';
    String enteredText = _textEditingController.text;
    setState(() {
      savedItems.add('$selectedItem - $enteredText');
    });
    widget.onSubmitfoods({'item': selectedItem, 'text': enteredText}, true);
    Navigator.of(context).pop();
  }
}
