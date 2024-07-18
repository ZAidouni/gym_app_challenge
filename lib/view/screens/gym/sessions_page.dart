import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat/chat_screen.dart';

class SessionsPage extends StatelessWidget {
  // Simulated list of sessions with titles and images
  final List<Map<String, dynamic>> sessions = [
    {
      "id": "session1",
      "title": "Séance de Cardio",
      "image": "assets/img/welcomeOverlayImg.png",
      "participants": 10, // Example participant count
    },
    {
      "id": "session2",
      "title": "Séance de Musculation",
      "image": "assets/img/welcomeOverlayImg.png",
      "participants": 5, // Example participant count
    },
    {
      "id": "session3",
      "title": "Séance de Yoga",
      "image": "assets/img/welcomeOverlayImg.png",
      "participants": 20, // Example participant count
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
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    style: TextStyle(
                      color: Colors.white,
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
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            Get.to(() => ChatScreen(sessionId: session["id"]));
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
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            // Action for the delete button
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.people, color: Colors.white, size: 18),
                      Text(
                        '${session["participants"]} participants',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
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
