import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeuxiemeTourScreen extends StatefulWidget {
  @override
  _DeuxiemeTourScreenState createState() => _DeuxiemeTourScreenState();
}

class _DeuxiemeTourScreenState extends State<DeuxiemeTourScreen> {
  DateTime? startDate;
  DateTime? endDate;
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (startDate ?? DateTime.now())
          : (endDate ?? DateTime.now()),
      firstDate: isStartDate ? DateTime(2000) : (startDate ?? DateTime(2000)),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(14, 128, 52, 1),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          if (endDate != null && endDate!.isBefore(startDate!)) {
            endDate = null;
          }
        } else {
          endDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Date de début: ${DateFormat('dd/MM/yyyy').format(startDate!)}');
      print('Date de fin: ${DateFormat('dd/MM/yyyy').format(endDate!)}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Formulaire soumis avec succès!',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          backgroundColor: Color.fromRGBO(14, 128, 52, 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Deuxième Tour',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Date de début
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date de début',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () => _selectDate(context, true),
                              decoration: InputDecoration(
                                hintText: 'Sélectionner une date',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                suffixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Color.fromRGBO(14, 128, 52, 1),
                                  size: 20,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                text: startDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(startDate!)
                                    : '',
                              ),
                              validator: (value) {
                                if (startDate == null) {
                                  return 'Veuillez sélectionner une date de début';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      // Date de fin
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date de fin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              onTap: () => _selectDate(context, false),
                              decoration: InputDecoration(
                                hintText: 'Sélectionner une date',
                                hintStyle:
                                    TextStyle(color: Colors.grey.shade400),
                                suffixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: Color.fromRGBO(14, 128, 52, 1),
                                  size: 20,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 14),
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                text: endDate != null
                                    ? DateFormat('dd/MM/yyyy').format(endDate!)
                                    : '',
                              ),
                              validator: (value) {
                                if (endDate == null) {
                                  return 'Veuillez sélectionner une date de fin';
                                }
                                if (startDate != null &&
                                    endDate!.isBefore(startDate!)) {
                                  return 'La date de fin doit être après la date de début';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                // Bouton de soumission
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text(
                      'Créer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(14, 128, 52, 1),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
