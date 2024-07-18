import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../gym/sessions_page.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final _user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    FirebaseFirestore.instance.collection('messages').orderBy('createdAt').snapshots().listen((snapshot) {
      final messages = snapshot.docs.map((doc) {
        final data = doc.data();
        final author = types.User(
          id: data['authorId'],
          firstName: data['authorName'],
          imageUrl: data['authorImageUrl'],
        );
        return types.TextMessage(
          author: author,
          createdAt: data['createdAt'],
          id: doc.id,
          text: data['text'],
        );
      }).toList();

      setState(() {
        _messages
          ..clear()
          ..addAll(messages.reversed);  // Reverse the list to show the newest messages at the bottom
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Conversation')
    ),
    body: _user == null
        ? const Center(child: CircularProgressIndicator())
        : Chat(
      theme: const DarkChatTheme(
        inputBackgroundColor: Colors.white,
        inputTextColor: Colors.black,
      ),
      messages: _messages,
      onSendPressed: _handleSendPressed,
      user: types.User(
        id: _user!.uid,
        firstName: _user!.displayName ?? "User",
        imageUrl: _user!.photoURL ?? 'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile.png',
      ),
      onAttachmentPressed: _handleImageSelection,
    ),
  );

  void _addMessage(types.Message message) async {
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'authorId': _user!.uid,
        'authorName': _user!.displayName,
        'authorImageUrl': _user!.photoURL,
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'text': (message as types.TextMessage).text,
      });
      print('Message sent successfully');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: types.User(
        id: _user!.uid,
        firstName: _user!.displayName ?? "User",
        imageUrl: _user!.photoURL ?? 'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile.png',
      ),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: types.User(
          id: _user!.uid,
          firstName: _user!.displayName ?? "User",
          imageUrl: _user!.photoURL ?? 'https://www.pngall.com/wp-content/uploads/12/Avatar-Profile.png',
        ),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }
}