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

class AddGroupSessionPage extends StatefulWidget {
  @override
  _AddGroupSessionPageState createState() => _AddGroupSessionPageState();
}

class _AddGroupSessionPageState extends State<AddGroupSessionPage> with DelayHelperMixin {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _workOutTitleController = TextEditingController();
  final TextEditingController _imagePathController = TextEditingController();
  final TextEditingController _timeLeftInHourController = TextEditingController();
  final TextEditingController _movesNumberController = TextEditingController();
  final TextEditingController _setsNumberController = TextEditingController();
  final TextEditingController _durationInMinutesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();
  final TextEditingController _priceInDollarsController = TextEditingController();

  // State variables for boolean values
  bool _hasFreeTrial = false;
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
                            style: const TextStyle(color: Colors.white), // Couleur du texte sélectionné
                            items: _exerciseTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Couleur des éléments de la liste
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedExerciseType = newValue;
                              });
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
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _timeLeftInHourController,
                            label: 'Temps de l\'exercice',
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _movesNumberController,
                            label: 'Nombre de mouvements',
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _setsNumberController,
                            label: 'Nombre de séries',
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _durationInMinutesController,
                            label: 'Durée de séries en minutes',
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: DropdownButtonFormField<String>(
                            decoration: _inputDecoration('Évaluation'),
                            dropdownColor: const Color.fromARGB(255, 0, 0, 0),
                            value: _selectedRating,
                            style: const TextStyle(color: Colors.white), // Couleur du texte sélectionné
                            items: _ratings.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)), // Couleur des éléments de la liste
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectedRating = newValue;
                              });
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
                          ),
                        ),
                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay: getDelayDuration(),
                          child: CustomTextField(
                            keyboardType: TextInputType.text,
                            controller: _commentsController,
                            label: 'Commentaires',
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
      checkColor: Colors.white, // Couleur du coche (marqueur)
      activeColor: Colors.transparent, // Couleur de fond lorsque la case est cochée (transparente pour ne pas changer le fond)
      side: BorderSide(color: Colors.white), // Couleur du bord de la case à cocher
    ),
    const SizedBox(width: 10), // Espacement entre la checkbox et le texte
    const Text(
      'Entraînement du jour',
      style: TextStyle(
        color: Colors.white, // Couleur du texte
        fontSize: 16, // Taille du texte (si nécessaire)
      ),
    ),
  ],
),
                        const SizedBox(height: 20),
                     Column(
                        children: [
                          DelayedDisplay(
                            delay: getDelayDuration(),
                            child: CustomButton(
                              onPressed: () {
                               
                              },
                              isRounded: false,
                              text: (AppTexts.publier),
                              isOutlined: false,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          )
                        
                        ],
                      )
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
