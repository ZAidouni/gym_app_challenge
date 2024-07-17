import 'package:flutter/material.dart';

class CoachSessionsPage extends StatelessWidget {
  // Liste simulée des séances avec des titres et des images
  final List<Map<String, String>> sessions = [
    {
      "title": "Séance de Cardio",
      "image": "imgs/welcomeOverlayImg.png",
    },
    {
      "title": "Séance de Musculation",
      "image": "imgs/welcomeOverlayImg.png",
    },
    {
      "title": "Séance de Yoga",
      "image": "imgs/welcomeOverlayImg.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff131429),
      appBar: AppBar(
        backgroundColor: const Color(0xff131429),
        title: Text(
          'Mes Séances',
          style: TextStyle(
            color: Colors.white, // Changez cette couleur selon vos besoins
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue, // Couleur du bouton "Détails"
                            padding: EdgeInsets.symmetric(vertical: 12), // Ajustez le padding si nécessaire
                          ),
                          onPressed: () {
                            // Action pour le premier bouton
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.message, color: Colors.white),
                              SizedBox(width: 5),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Espace entre les boutons
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Couleur du bouton "Supprimer"
                            padding: EdgeInsets.symmetric(vertical: 12), // Ajustez le padding si nécessaire
                          ),
                          onPressed: () {
                            // Action pour le deuxième bouton
                          },
                          child: Row(
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
