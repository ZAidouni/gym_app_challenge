import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import '../controller/functionsController/dialogsAndLoadingController.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  final DialogsAndLoadingController dialogsAndLoadingController =
      Get.find();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play(); // Commence la lecture dès que la vidéo est initialisée
        });
      }).catchError((error) {
        print('Erreur lors de l\'initialisation de la vidéo: $error');
      });
  }

  @override
  void dispose() {
    // Arrête la vidéo et libère les ressources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _controller.pause(); // Arrête la vidéo lorsque l'utilisateur quitte la page
        return true; // Permet de quitter la page
      },
      child: Scaffold(
        backgroundColor: const Color(0xff131429),
        appBar: AppBar(
          backgroundColor: const Color(0xff131429),
          title: Text(
            'Lecture Vidéo',
            style: TextStyle(color: Colors.white), // Texte en blanc
          ),
        ),
        body: Center(
          child: _controller.value.isInitialized
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                    Slider(
                      value: _controller.value.position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _controller.value.duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _controller.seekTo(Duration(seconds: value.toInt()));
                        });
                      },
                      activeColor: Colors.white, // Couleur du curseur en blanc
                      inactiveColor: Colors.white54, // Couleur du curseur non actif en blanc transparent
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white, // Icône en blanc
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              });
                            },
                          ),
                          Text(
                            "${_controller.value.position.toString().split('.').first} / ${_controller.value.duration.toString().split('.').first}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // Texte en blanc
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ), // Indicateur de chargement en blanc
        ),
      ),
    );
  }
}
