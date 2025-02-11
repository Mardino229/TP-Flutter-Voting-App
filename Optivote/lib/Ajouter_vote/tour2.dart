import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:optivote/data/services/election_service.dart';


class SecondTourScreen extends StatefulWidget {
  final String id;

  SecondTourScreen({required this.id});
  @override
  _SecondTourScreenState createState() => _SecondTourScreenState();
}

class _SecondTourScreenState extends State<SecondTourScreen> {
  DateTime? startDate;
  DateTime? endDate;
  bool loading = false;
  final ElectionService electionService = ElectionService();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (startDate ?? DateTime.now())
          : (endDate ?? startDate ?? DateTime.now()),
      firstDate: isStartDate ? DateTime.now() : startDate ?? DateTime.now(),
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


  createElectionSecondTour() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      try {
        print(startDate);
        Map<String, dynamic> data = {
          'start_date': DateFormat('yyyy/MM/dd').format(startDate!),
          'end_date': DateFormat('yyyy/MM/dd').format(endDate!),
        };
        final response = await electionService.secondTour(widget.id, data);

        if (response["success"]) {
          // Election election = Election.fromJson(response["body"]);
          // context.push("/detail_election/${election.id}");

          Fluttertoast.showToast(msg: response["message"]);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${response["message"]}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: Color.fromRGBO(14, 128, 52, 1),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          context.push("/dashboard_vote");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${response["message"]}',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
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

          // setState(() {
          //   if (errors["start_date"]!=null){
          //     _startError =errors["start_date"][0].toString();
          //   }
          //   if (errors["end_date"]!=null){
          //     _endError = errors["end_date"][0].toString();
          //   }
          // });

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Deuxième Tour',
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
        elevation: 0,
        automaticallyImplyLeading: false, // Désactive le bouton de retour automatique
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(); // Action de retour personnalisée
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
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
                                    ? DateFormat('yyyy/MM/dd')
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
                                    ? DateFormat('yyyy/MM/dd').format(endDate!)
                                    : '',
                              ),
                              validator: (value) {
                                if (endDate == null) {
                                  return 'Veuillez sélectionner une date de fin';
                                }
                                if (startDate != null &&
                                    endDate!.isBefore(startDate!)) {
                                  return 'La date de fin doit être égale ou après la date de début';
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
                    onPressed: createElectionSecondTour,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(14, 128, 52, 1),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: !loading
                        ? Text(
                            'Créer',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: Colors.white),
                          )
                        : SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
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
