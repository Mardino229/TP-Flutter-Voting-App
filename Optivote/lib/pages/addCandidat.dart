import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optivote/data/services/candidat_service.dart';

class AddCandidat extends StatefulWidget {
  final String id;

  const AddCandidat({super.key, required, required this.id});

  @override
  State<AddCandidat> createState() => _AddCandidatState();
}

class _AddCandidatState extends State<AddCandidat> {
  final _formKey = GlobalKey<FormState>();
  List<CandidatFields> candidatFields = [CandidatFields()];
  final ImagePicker _picker = ImagePicker();
  final candidatService = CandidatService();
  bool loading = false;
  bool _isSubmitting = false;

  void addNewFields() {
    setState(() {
      candidatFields.add(CandidatFields());
    });
  }

  void removeFields(int index) {
    setState(() {
      candidatFields[index].npiController.dispose();
      candidatFields[index].descriptionController.dispose();
      candidatFields.removeAt(index);
    });
  }

  Future<void> pickImage(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          candidatFields[index].imageFile = File(pickedFile.path);
          candidatFields[index].hasImageError = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la sélection de l\'image'),
          backgroundColor: Colors.red,
        ),
      );
      debugPrint('Erreur lors de la sélection de l\'image: $e');
    }
  }

  bool validateFields() {
    bool isValid = _formKey.currentState?.validate() ?? false;

    // Vérification des images
    for (int i = 0; i < candidatFields.length; i++) {
      if (candidatFields[i].imageFile == null) {
        setState(() {
          candidatFields[i].hasImageError = true;
        });
        isValid = false;
      }
    }

    return isValid;
  }

  void submitForm() {
    setState(() {
      _isSubmitting = true;
    });

    if (validateFields()) {
      addCandidat();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     content: Text('Formulaire valide - Données prêtes à être envoyées'),
      //     backgroundColor: Colors.green,
      //   ),
      // );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les erreurs dans le formulaire'),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      _isSubmitting = false;
    });
  }

  addCandidat () async {
    if (validateFields()) {
      setState(() {
        _isSubmitting = true;
      });
      try {
        for (int i=0; i<candidatFields.length; i++){
          Map<String, dynamic> data = {
            'npi': candidatFields[i].npiController.text,
            'description': candidatFields[i].descriptionController.text,
            'election_id': widget.id,
          };
          final response = await candidatService.add(data,candidatFields[i].imageFile);
          if (response["success"]){
            context.push("/detail_election/${widget.id}");
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
          } else {
            context.push("/detail_election/${widget.id}");
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
        }
        // dispose();

      } on DioException catch (e) {

        if (e.response != null) {
          // print(e.response?.data["errors"]);
          final errors = e.response?.data['errors'];
          errors.forEach((key, value) {
            // print('$key: $value');
            Fluttertoast.showToast(msg: value[0].toString()); // Affiche chaque erreur
          });
          //
          // print(formattedErrors);
          // Map<String, String> errors = e.response?.data["errors"];

          // setState(() {
          //   // if (errors["start_date"]!=null){
          //   //   _startError =errors["start_date"][0].toString();
          //   // }
          //   // if (errors["end_date"]!=null){
          //   //   _endError = errors["end_date"][0].toString();
          //   // }
          // });
          // print(e.response?.statusCode);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          // print(e.requestOptions);
          // print(e.message);
          Fluttertoast.showToast(msg: "Une erreur est survenue");
        }
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les erreurs dans le formulaire'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    for (var field in candidatFields) {
      field.npiController.dispose();
      field.descriptionController.dispose();
    }
    super.dispose();
  }

  String? validateNPI(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le NPI est requis';
    }
    // if (!RegExp(r'^\d{9}$').hasMatch(value)) {
    //   return 'Le NPI doit contenir exactement 10 chiffres';
    // }
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'La description est requise';
    }
    if (value.length < 10) {
      return 'La description doit contenir au moins 10 caractères';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(14, 128, 52, 1),
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
        title: const Text(
          'Ajouter un candidat',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.white),
            onPressed: addNewFields,
            tooltip: 'Ajouter un autre candidat',
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...candidatFields.asMap().entries.map((entry) {
                final index = entry.key;
                final field = entry.value;
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(14, 128, 52, 1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Candidat ${index + 1}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              if (candidatFields.length > 1)
                                IconButton(
                                  onPressed: () => removeFields(index),
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red.shade400,
                                  tooltip: 'Supprimer ce candidat',
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => pickImage(index),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 60,
                                          backgroundColor: field.hasImageError
                                              ? Colors.red.shade100
                                              : Colors.grey[200],
                                          backgroundImage:
                                              field.imageFile != null
                                                  ? FileImage(field.imageFile!)
                                                  : null,
                                          child: field.imageFile == null
                                              ? Icon(
                                                  Icons.add_a_photo,
                                                  size: 40,
                                                  color: field.hasImageError
                                                      ? Colors.red
                                                      : Colors.grey,
                                                )
                                              : null,
                                        ),
                                        if (field.imageFile != null)
                                          Positioned(
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: const BoxDecoration(
                                                color: Colors.blue,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.edit,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    if (field.hasImageError)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          'La photo est requise',
                                          style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: field.npiController,
                                decoration: InputDecoration(
                                  labelText: 'NPI du candidat',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.badge),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  helperText:
                                      'Le NPI doit contenir 10 chiffres',
                                ),
                                keyboardType: TextInputType.number,
                                validator: validateNPI,
                                maxLength: 10,
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: field.descriptionController,
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  hintText: 'Décrivez le candidat',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(Icons.description),
                                  filled: true,
                                  fillColor: Colors.grey[50],
                                  helperText: 'Minimum 10 caractères',
                                ),
                                maxLines: 3,
                                validator: validateDescription,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: addCandidat,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.save,
                          color: Colors.white,
                          size: 20,
                  ),
                  label:
                  Text(
                    _isSubmitting
                        ? 'Enregistrement... ' :
                    'Enregistrer tous les candidats',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(14, 128, 52, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CandidatFields {
  final TextEditingController npiController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? imageFile;
  bool hasImageError = false;
}
