import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:optivote/data/models/election.dart';
import 'package:optivote/data/services/election_service.dart';

class CreateVotePage extends StatefulWidget {
  @override
  _CreateVotePageState createState() => _CreateVotePageState();
}

class _CreateVotePageState extends State<CreateVotePage> {
  DateTime? _startDate; // Date de début
  DateTime? _endDate; // Date de fin
  bool loading = false;
  final _titreController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final Color _darkGreen = Color(0xFF006400);
  final electionService = ElectionService();
  String? _startError;
  String? _endError;

  createElection() async {
    setState(() {
      loading = true;
    });
    try {
      print(_startDate);
      Map<String, dynamic> data = {
        'name': _titreController.text,
        'start_date': _startDateController.text,
        'end_date': _endDateController.text,
      };
      final response = await electionService.create(data);

      if (response["success"]) {
        // Election election = Election.fromJson(response["body"]);
        // context.push("/detail_election/${election.id}");
        context.push("/dashboard_vote");
        Fluttertoast.showToast(msg: response["message"]);
      }
      // dispose();
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data["errors"]);
        final errors = e.response?.data['errors'];
        errors.forEach((key, value) {
          print('$key: $value'); // Affiche chaque erreur
        });
        //
        // print(formattedErrors);
        // Map<String, String> errors = e.response?.data["errors"];

        setState(() {
          if (errors["start_date"] != null) {
            _startError = errors["start_date"][0].toString();
          }
          if (errors["end_date"] != null) {
            _endError = errors["end_date"][0].toString();
          }
        });

        print(e.response?.statusCode);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }

      Fluttertoast.showToast(msg: "Une erreur est survenue");
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _darkGreen,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Créer une élection",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildVoteForm(),
                  _buildCreateButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section 3 : Formulaire de vote
  Widget _buildVoteForm() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _darkGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              "Élection",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _titreController,
                  decoration: InputDecoration(
                    labelText: "Titre",
                    labelStyle: TextStyle(color: _darkGreen),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _darkGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                ),
                SizedBox(height: 20),
                _buildDateField(
                  label: "Date de début",
                  controller: _startDateController,
                  errorText: _startError,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _startDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: _darkGreen,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        _startDateController.text = formattedDate;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                _buildDateField(
                  label: "Date de fin",
                  controller: _endDateController,
                  errorText: _endError,
                  onTap: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _endDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: _darkGreen,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        _endDateController.text = formattedDate;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
    String? errorText,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: _darkGreen),
          errorText: errorText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _darkGreen),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              controller.text.isNotEmpty
                  ? controller.text
                  : "Sélectionnez une date",
              style: TextStyle(
                color: controller.text.isNotEmpty
                    ? Colors.black87
                    : Colors.grey.shade600,
              ),
            ),
            Icon(Icons.calendar_today, color: _darkGreen),
          ],
        ),
      ),
    );
  }

  // Section 6 : Bouton de création
  Widget _buildCreateButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: _darkGreen,
          minimumSize: Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        onPressed: !loading ? createElection : null,
        child: !loading
            ? Text(
                "Créer l'élection",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            : SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
