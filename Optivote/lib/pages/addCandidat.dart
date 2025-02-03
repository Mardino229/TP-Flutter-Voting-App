// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddCandidat extends StatefulWidget {
//   const AddCandidat({super.key});

//   @override
//   State<AddCandidat> createState() => _AddCandidatState();
// }

// class _AddCandidatState extends State<AddCandidat> {
//   List<CandidatFields> candidatFields = [CandidatFields()];
//   final ImagePicker _picker = ImagePicker();

//   void addNewFields() {
//     setState(() {
//       candidatFields.add(CandidatFields());
//     });
//   }

//   void removeFields(int index) {
//     setState(() {
//       candidatFields[index].npiController.dispose();
//       candidatFields[index].descriptionController.dispose();
//       candidatFields.removeAt(index);
//     });
//   }

//   Future<void> pickImage(int index) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           candidatFields[index].imageFile = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       debugPrint('Erreur lors de la sélection de l\'image: $e');
//     }
//   }

//   @override
//   void dispose() {
//     for (var field in candidatFields) {
//       field.npiController.dispose();
//       field.descriptionController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ajouter un candidat'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ...candidatFields.asMap().entries.map((entry) {
//               final index = entry.key;
//               final field = entry.value;
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 16.0),
//                 child: Card(
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Candidat ${index + 1}',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             if (candidatFields.length > 1)
//                               IconButton(
//                                 onPressed: () => removeFields(index),
//                                 icon: const Icon(Icons.delete),
//                                 color: Colors.red,
//                               ),
//                           ],
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: field.npiController,
//                           decoration: const InputDecoration(
//                             labelText: 'NPI du candidat',
//                             border: OutlineInputBorder(),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         TextFormField(
//                           controller: field.descriptionController,
//                           decoration: const InputDecoration(
//                             labelText: 'Description',
//                             border: OutlineInputBorder(),
//                             hintText: 'Décrivez le candidat',
//                           ),
//                           maxLines: 3,
//                         ),
//                         const SizedBox(height: 16),
//                         Center(
//                           child: Column(
//                             children: [
//                               if (field.imageFile != null)
//                                 Container(
//                                   width: 200,
//                                   height: 200,
//                                   margin: const EdgeInsets.only(bottom: 8),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: Image.file(
//                                       field.imageFile!,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               ElevatedButton.icon(
//                                 onPressed: () => pickImage(index),
//                                 icon: const Icon(Icons.photo_camera),
//                                 label: Text(
//                                   field.imageFile == null
//                                       ? 'Ajouter une photo'
//                                       : 'Changer la photo',
//                                 ),
//                                 style: ElevatedButton.styleFrom(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 16,
//                                     vertical: 8,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: Wrap(
//                 spacing: 16,
//                 runSpacing: 16,
//                 alignment: WrapAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: addNewFields,
//                     icon: const Icon(Icons.add),
//                     label: const Text('Ajouter un autre candidat'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () {
//                       // TODO: Implémenter la logique de sauvegarde
//                     },
//                     icon: const Icon(Icons.save),
//                     label: const Text('Enregistrer'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CandidatFields {
//   final TextEditingController npiController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   File? imageFile;
// }

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddCandidat extends StatefulWidget {
//   const AddCandidat({super.key});

//   @override
//   State<AddCandidat> createState() => _AddCandidatState();
// }

// class _AddCandidatState extends State<AddCandidat> {
//   List<CandidatFields> candidatFields = [CandidatFields()];
//   final ImagePicker _picker = ImagePicker();

//   void addNewFields() {
//     setState(() {
//       candidatFields.add(CandidatFields());
//     });
//   }

//   void removeFields(int index) {
//     setState(() {
//       candidatFields[index].npiController.dispose();
//       candidatFields[index].descriptionController.dispose();
//       candidatFields.removeAt(index);
//     });
//   }

//   Future<void> pickImage(int index) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1800,
//         maxHeight: 1800,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           candidatFields[index].imageFile = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       debugPrint('Erreur lors de la sélection de l\'image: $e');
//     }
//   }

//   @override
//   void dispose() {
//     for (var field in candidatFields) {
//       field.npiController.dispose();
//       field.descriptionController.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Ajouter un candidat',
//           style: TextStyle(
//             color: Colors.black87,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person_add, color: Colors.blue),
//             onPressed: addNewFields,
//             tooltip: 'Ajouter un autre candidat',
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ...candidatFields.asMap().entries.map((entry) {
//               final index = entry.key;
//               final field = entry.value;
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 child: Card(
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.blue.shade50,
//                           borderRadius: const BorderRadius.only(
//                             topLeft: Radius.circular(15),
//                             topRight: Radius.circular(15),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'Candidat ${index + 1}',
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             if (candidatFields.length > 1)
//                               IconButton(
//                                 onPressed: () => removeFields(index),
//                                 icon: const Icon(Icons.delete_outline),
//                                 color: Colors.red,
//                                 tooltip: 'Supprimer ce candidat',
//                               ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(24.0),
//                         child: Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () => pickImage(index),
//                               child: Stack(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 60,
//                                     backgroundColor: Colors.grey[200],
//                                     backgroundImage: field.imageFile != null
//                                         ? FileImage(field.imageFile!)
//                                         : null,
//                                     child: field.imageFile == null
//                                         ? const Icon(
//                                             Icons.add_a_photo,
//                                             size: 40,
//                                             color: Colors.grey,
//                                           )
//                                         : null,
//                                   ),
//                                   if (field.imageFile != null)
//                                     Positioned(
//                                       right: 0,
//                                       bottom: 0,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(4),
//                                         decoration: const BoxDecoration(
//                                           color: Colors.blue,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(
//                                           Icons.edit,
//                                           size: 20,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 24),
//                             TextFormField(
//                               controller: field.npiController,
//                               decoration: InputDecoration(
//                                 labelText: 'NPI du candidat',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 prefixIcon: const Icon(Icons.badge),
//                                 filled: true,
//                                 fillColor: Colors.grey[50],
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             TextFormField(
//                               controller: field.descriptionController,
//                               decoration: InputDecoration(
//                                 labelText: 'Description',
//                                 hintText: 'Décrivez le candidat',
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 prefixIcon: const Icon(Icons.description),
//                                 filled: true,
//                                 fillColor: Colors.grey[50],
//                               ),
//                               maxLines: 3,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }).toList(),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: ElevatedButton.icon(
//                 onPressed: () {
//                   // TODO: Implémenter la logique de sauvegarde
//                 },
//                 icon: const Icon(Icons.save),
//                 label: const Text(
//                   'Enregistrer tous les candidats',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 32,
//                     vertical: 16,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   elevation: 3,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CandidatFields {
//   final TextEditingController npiController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   File? imageFile;
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCandidat extends StatefulWidget {
  const AddCandidat({super.key});

  @override
  State<AddCandidat> createState() => _AddCandidatState();
}

class _AddCandidatState extends State<AddCandidat> {
  final _formKey = GlobalKey<FormState>();
  List<CandidatFields> candidatFields = [CandidatFields()];
  final ImagePicker _picker = ImagePicker();
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
      // TODO: Implémenter la logique de sauvegarde
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formulaire valide - Données prêtes à être envoyées'),
          backgroundColor: Colors.green,
        ),
      );
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
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Le NPI doit contenir exactement 10 chiffres';
    }
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
        backgroundColor: Colors.white,
        title: const Text(
          'Ajouter un candidat',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add, color: Colors.blue),
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
                            color: Colors.blue.shade50,
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
                                  color: Colors.black87,
                                ),
                              ),
                              if (candidatFields.length > 1)
                                IconButton(
                                  onPressed: () => removeFields(index),
                                  icon: const Icon(Icons.delete_outline),
                                  color: Colors.red,
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
              }).toList(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton.icon(
                  onPressed: _isSubmitting ? null : submitForm,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(
                    _isSubmitting
                        ? 'Enregistrement...'
                        : 'Enregistrer tous les candidats',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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
