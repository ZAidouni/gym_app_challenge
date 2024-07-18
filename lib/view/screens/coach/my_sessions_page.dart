import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chat/chat_screen.dart';

class CoachSessionsPage extends StatelessWidget {
  // List of sessions with titles and images
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
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          return Card(
            color: const Color(0xff1C1F2E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  session["image"]!,
                  fit: BoxFit.cover,
                  height: 120,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    session["title"]!,
                    style: const TextStyle(
                      color: Colors.white,
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
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
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
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            // Action for the delete button
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
