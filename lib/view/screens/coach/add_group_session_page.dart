import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_out/config/Colors.dart';
import 'package:work_out/config/text.dart';
import '../../../config/show_delay_mixin.dart';
import '../../widgets/general_widgets/button.dart';
import '../../widgets/general_widgets/mainScreenTitle.dart';
import '../../widgets/general_widgets/screen_background_image.dart';
import '../../widgets/general_widgets/text field.dart';
import '../../widgets/general_widgets/titleWithDescription.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:work_out/services/openai_service.dart';
import 'package:work_out/view/screens/coach/my_sessions_page.dart';

class AddGroupSessionPage extends StatefulWidget {
  @override
  _AddGroupSessionPageState createState() => _AddGroupSessionPageState();
}

class _AddGroupSessionPageState extends State<AddGroupSessionPage> with DelayHelperMixin {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _workOutTitleController = TextEditingController();
  final TextEditingController _timeLeftInHourController = TextEditingController();
  final TextEditingController _movesNumberController = TextEditingController();
  final TextEditingController _setsNumberController = TextEditingController();
  final TextEditingController _durationInMinutesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
    final TextEditingController _localisation = TextEditingController();


  // State variables for boolean values
  bool _isWorkoutOfDay = false;

  // Dropdown values
  String? _selectedExerciseType;
  String? _selectedRating;

  final List<String> _exerciseTypes = [
    'Cardio',
    'Force',
    'Souplesse',
    'Équilibre',
  ];

  final List<String> _ratings = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];


  // Common decoration for both text fields and dropdowns
  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      filled: true,
      fillColor: const Color(0xFF1D1E33),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide.none,
      ),
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
      hintText: label,
      hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
      alignLabelWithHint: true,
    );
  }

  // Function to show the DatePicker and update the controller
  void _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    
    if (pickedDate != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: const [0.45, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.darkBlue,
                  AppColors.darkBlue.withOpacity(0.05),
                ],
              ),
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50), // Spacer at the top
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: MainScreenTitle(
                            mainWord: AppTexts.firstMainWord,
                            secondaryWord: AppTexts.secondaryMainWord,
                          ),
                        ),
                        const SizedBox(height: 20),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: RichText(
                            text: const TextSpan(
                              text: 'Créer Votre Séance de Groupe\n',
                              style: TextStyle(
                                height: 1.4,
                                letterSpacing: 1,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: DropdownButtonFormField<String>(
                            decoration: _inputDecoration('Type de l\'exercice'),
                            dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                            value: _selectedExerciseType,
                            style: const TextStyle(color: Colors.white),
                            items: _exerciseTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedExerciseType = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.name,
                            controller: _workOutTitleController,
                            label: 'Titre de l\'exercice',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _timeLeftInHourController,
                            label: 'Temps de l\'exercice',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                                if (!value.isNum) {
                                return 'veuillez entrez un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _movesNumberController,
                            label: 'Nombre de mouvements',
                            validator: (value) {
                              if (value == null || value.isEmpty ) {
                                return 'Ce champ est requis';
                              }
                              if (!value.isNum) {
                                return 'veuillez entrez un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _setsNumberController,
                            label: 'Nombre de séries',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                                if (!value.isNum) {
                                return 'veuillez entrez un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _durationInMinutesController,
                            label: 'Durée de séries en minutes',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                                if (!value.isNum) {
                                return 'veuillez entrez un nombre';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: DropdownButtonFormField<String>(
                            decoration: _inputDecoration('Évaluation'),
                            dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                            value: _selectedRating,
                            style: const TextStyle(color: Colors.white),
                            items: _ratings.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRating = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.text,
                            controller: _descriptionController,
                            label: 'Description',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                keyboardType: TextInputType.text,
                                controller: _dateController,
                                label: 'Date de la séance',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Ce champ est requis';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                         const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.text,
                            controller: _localisation,
                            label: 'Lien google maps de votre salle',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ce champ est requis';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Checkbox(
                              value: _isWorkoutOfDay,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isWorkoutOfDay = value ?? false;
                                });
                              },
                              checkColor: Colors.white,
                              activeColor: Colors.transparent,
                              side: BorderSide(color: Colors.white),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Entraînement du jour',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomButton(
                            onPressed: () async {
                              if (_formKey.currentState?.validate() ?? false) {
                                
    final openAIService = OpenAIService();
    final prompt =
        'Génère moi une review en max 60 mots pour cet exercise creer par le coach en se basant sur le titre de l\'exercie ($_workOutTitleController), le nombre de mouvement ($_movesNumberController), le nombre de repétition ($_setsNumberController) et la description ($_descriptionController)';

   
      final generatedDescription =
          await openAIService.generateDescription(prompt);

  
  
                                // Gather the data
                                final Map<String, dynamic> data = {
                                  'workOutTitle': _workOutTitleController.text,
                                  'timeLeftInHour': _timeLeftInHourController.text,
                                  'movesNumber': _movesNumberController.text,
                                  'setsNumber': _setsNumberController.text,
                                  'durationInMinutes': _durationInMinutesController.text,
                                  'description': _descriptionController.text,
                                  'date': _dateController.text,
                                  'localisation': _localisation.text,
                                  'exerciseType': _selectedExerciseType,
                                  'reviews': generatedDescription,
                                  'rating': _selectedRating,
                                  'isWorkoutOfDay': _isWorkoutOfDay,
                                };
                                // Convert data to JSON
                                final String jsonData = jsonEncode(data);
                                // URL of your backend endpoint
                                final String url = 'https://example.com/api/group-session'; // Replace with your backend URL

                                try {
                                  // Send POST request
                                  final response = await http.post(
                                    Uri.parse(url),
                                    headers: <String, String>{
                                      'Content-Type': 'application/json; charset=UTF-8',
                                    },
                                    body: jsonData,
                                  );

                                  if (true) {
                                    // If the server returns a 200 OK response, consider it a success
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Session added successfully!')),
                                    );
                                    Get.to(() => CoachSessionsPage());
                                  } else {
                                    // If the server did not return a 200 OK response, handle it
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Failed to add session.')),
                                    );
                                  }
                                } catch (e) {
                                  // Handle exceptions, e.g., network issues
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error: $e')),
                                  );
                                }
                              } else {
                                // If the form is not valid, show an error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Please fill all fields correctly.')),
                                );
                              }
                            },
                            isRounded: false,
                            text: AppTexts.publier,
                            isOutlined: false,
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
