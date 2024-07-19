import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chat/chat_screen.dart';

class CoachSessionsPage extends StatefulWidget {
  @override
  _SessionsPageState createState() => _SessionsPageState();
}

class _SessionsPageState extends State<CoachSessionsPage> {
  bool showActiveSessions = true;

  // Simulated list of sessions with titles and images
  List<Map<String, dynamic>> sessions = [
    {
      "id": "session1",
      "title": "Séance de Cardio",
      "image": "assets/img/welcomeOverlayImg.png",
      "participants": 10, // Example participant count
      "isActive": true,
    },
    {
      "id": "session2",
      "title": "Séance de Musculation",
      "image": "assets/img/welcomeOverlayImg.png",
      "participants": 5, // Example participant count
      "isActive": true,
    },
    {
      "id": "session3",
      "title": "Séance de Yoga",
      "image": "assets/img/welcomeOverlayImg.png",
      "participants": 20, // Example participant count
      "isActive": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredSessions = sessions
        .where((session) => session["isActive"] == showActiveSessions)
        .toList();

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
        actions: [
          IconButton(
            icon: Icon(showActiveSessions ? Icons.filter_alt_outlined : Icons.archive_outlined),
            color: Colors.white,
            onPressed: () {
              setState(() {
                showActiveSessions = !showActiveSessions;
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        itemCount: filteredSessions.length,
        itemBuilder: (context, index) {
          final session = filteredSessions[index];
          return Card(
            color: const Color(0xff1C1F2E),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  session["image"]!,
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    session["title"]!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
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
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () {
                            Get.to(() => ChatScreen(sessionId: session["id"], isActive: session["isActive"]));
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
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          onPressed: () {
                            // Action for the delete button
                            setState(() {
                              // Remove the session from the list
                              sessions.remove(session);
                            });
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
