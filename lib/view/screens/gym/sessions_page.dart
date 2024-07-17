import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:work_out/view/screens/chat/chat_screen.dart';

class SessionsPage extends StatelessWidget {
  // Liste simulée des séances avec des titres et des images
  final List<Map<String, String>> sessions = [
    {
      "title": "Séance de Cardio",
      "image": "assets/img/welcomeOverlayImg.png",
    },
    {
      "title": "Séance de Musculation",
      "image": "assets/img/welcomeOverlayImg.png",
    },
    {
      "title": "Séance de Yoga",
      "image": "assets/img/welcomeOverlayImg.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131429),
      appBar: AppBar(
        backgroundColor: const Color(0xff131429),
        title: const Text(
          'Mes Séances',
          style: TextStyle(
            color: Colors.white, // Changez cette couleur selon vos besoins
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Nombre de colonnes
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75, // Proportion des éléments
        ),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return Card(
            color: const Color(0xff1C1F2E), // Couleur de fond de la carte
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  session["image"]!,
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ), // Affiche l'image
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    session["title"]!,
                    style: const TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green, // Couleur du bouton "Détails"
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            // Rediriger vers la page chat_screen
                            Get.to(() => const ChatScreen());
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.message, color: Colors.white),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // Espace entre les boutons
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Couleur du bouton "Supprimer"
                            padding: const EdgeInsets.symmetric(vertical: 12), // Ajustez le padding si nécessaire
                          ),
                          onPressed: () {
                            // Action pour le deuxième bouton
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, color: Colors.white),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
